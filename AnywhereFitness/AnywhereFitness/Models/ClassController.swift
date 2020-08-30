//
//  ClassController.swift
//  AnywhereFitness
//
//  Created by Cora Jacobson on 8/25/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import Foundation
import CoreData
import Firebase

class ClassController {
    
    static let shared = ClassController()
    
    private init() { }
    
    private let firebaseURL = URL(string: "https://anywherefitness-ba403.firebaseio.com/classes")!
    
    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
    
    
    // MARK: - Firebase Server
        
    func getClasses(completion: @escaping CompletionHandler) {
            var request = URLRequest(url: firebaseURL)
            request.httpMethod = HTTPMethod.get.rawValue
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error receiving class data: \(error)")
                    completion(.failure(.tryAgain))
                    return
                }
                guard let response = response as? HTTPURLResponse,
                    response.statusCode == 200 else {
                    completion(.failure(.failedResponse))
                    return
                }
                guard let data = data else {
                    print("No data received from getClasses")
                    completion(.failure(.noData))
                    return
                }
                let jsonDecoder = JSONDecoder()
                do {
                    let classRepresentations = Array(try jsonDecoder.decode([String: ClassRepresentation].self, from: data).values)
                    try self.updateClasses(with: classRepresentations)
                    completion(.success(true))
                } catch {
                    print("Error decoding class data: \(error)")
                    completion(.failure(.tryAgain))
                    return
                }
            }
            task.resume()
        }
    
    private func update(classListing: ClassListing, representation: ClassRepresentation) {
        classListing.classTitle = representation.classTitle
        classListing.instructorID = representation.instructorID
        classListing.classType = representation.classType
        classListing.startTime = representation.startTime
        classListing.location = representation.location
        classListing.duration = representation.duration
        classListing.intensity = representation.intensity
        classListing.maxClassSize = Int16(representation.maxClassSize)
        classListing.attendees = representation.attendees.map{$0}.joined(separator: ", ")
    }
    
    private func updateClasses(with representations: [ClassRepresentation]) throws {
        let context = CoreDataStack.shared.container.newBackgroundContext()
        let identifiersToFetch = representations.compactMap({UUID(uuidString: $0.identifier)})
        let representationsByID = Dictionary(uniqueKeysWithValues: zip(identifiersToFetch, representations))
        var classesToCreate = representationsByID
        let fetchRequest: NSFetchRequest<ClassListing> = ClassListing.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "identifier IN %@", identifiersToFetch)
        context.performAndWait {
            do {
                let existingClasses = try context.fetch(fetchRequest)
                for classEntry in existingClasses {
                    guard let id = classEntry.identifier,
                        let representation = representationsByID[id] else {
                            continue }
                    update(classListing: classEntry, representation: representation)
                    classesToCreate.removeValue(forKey: id)
                }
                for representation in classesToCreate.values {
                    ClassListing(classRepresentation: representation, context: context)
                }
            } catch {
                print("Error fetching classes for UUIDs: \(error)")
            }
        }
        try CoreDataStack.shared.save(context: context)
    }
    
    func createClass(classListing: ClassListing, completion: @escaping CompletionHandler = { _ in }) {
        guard let uuid = classListing.identifier else {
            completion(.failure(.noIdentifier))
            return
        }
        let requestURL = firebaseURL.appendingPathComponent(uuid.uuidString).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        
        do {
            guard let representation = classListing.classRepresentation else {
                completion(.failure(.noRep))
                return
            }
            request.httpBody = try JSONEncoder().encode(representation)
        } catch {
            print("Error encoding class: \(error)")
            completion(.failure(.failedEncoding))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (_, _,  error) in
            if let error = error {
                print ("Error PUTting class to server: \(error)")
                completion(.failure(.otherError))
                return
            }
            completion(.success(true))
        }
        task.resume()
    }
    
    func deleteClass(_ classListing: ClassListing, completion: @escaping CompletionHandler = { _ in }) {
        guard let uuid = classListing.identifier else {
            completion(.failure(.noIdentifier))
            return
        }
        let requestURL = firebaseURL.appendingPathComponent(uuid.uuidString).appendingPathExtension("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = "DELETE"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(.success(true))
        }
        task.resume()
        let moc = CoreDataStack.shared.mainContext
        moc.delete(classListing)
        do {
            try moc.save()
        } catch {
            moc.reset()
            NSLog("Error saving managed object context: \(error)")
        }
    }
    
}
