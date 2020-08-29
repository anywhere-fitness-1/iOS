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
    
//    var bearer: Bearer?
//
//    private let baseURL = URL(string: "https://anywhere-fitness-1.herokuapp.com/api")!
//    private lazy var getClassesURL = baseURL.appendingPathComponent("/classes")
//    private lazy var createClassURL = baseURL.appendingPathComponent("/instructors/create-class")
    
    private let firebaseURL = URL(string: "https://anywherefitness-ba403.firebaseio.com/")!
    
    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
    
    var classListings: [ClassListing] = []

    
    // MARK: - Web Dev Server
    
//    func getClasses(completion: @escaping (Result<[ClassListing], NetworkError>) -> Void) {
//        guard let bearer = bearer else {
//            completion(.failure(.noToken))
//            return
//        }
//        var request = URLRequest(url: getClassesURL)
//        request.httpMethod = HTTPMethod.get.rawValue
//        request.setValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                print("Error receiving class data: \(error)")
//                completion(.failure(.tryAgain))
//                return
//            }
//            if let response = response as? HTTPURLResponse,
//                response.statusCode == 401 {
//                completion(.failure(.noToken))
//                return
//            }
//            guard let data = data else {
//                print("No data received from getClasses")
//                completion(.failure(.noData))
//                return
//            }
//            let jsonDecoder = JSONDecoder()
//            do {
//                let classes = try jsonDecoder.decode([ClassListing].self, from: data)
//                completion(.success(classes))
//
//            } catch {
//                print("Error decoding class data: \(error)")
//                completion(.failure(.tryAgain))
//            }
//        }
//        task.resume()
//    }
    
    // MARK: - Creating Class to Server
    
//    func createClass(classListing: ClassListing, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
//
//        guard let bearer = bearer else {
//            completion(.failure(.noToken))
//            return
//        }
//
//        var request = URLRequest(url: createClassURL)
//        request.httpMethod = HTTPMethod.post.rawValue
//        request.addValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        do {
//            let encoder = JSONEncoder()
//            encoder.dateEncodingStrategy = .iso8601
//            request.httpBody = try encoder.encode(classListing)
//        } catch {
//            print("Encoding classListing data failed: \(error)")
//        }
//
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            if let error = error {
//                print("No Data Encode \(error)")
//                return
//            }
//
//            if let response = response as? HTTPURLResponse,
//                response.statusCode == 401 {
//                completion(.failure(.failedResponse))
//                return
//            }
//
//            guard let data = data else {
//                print("Data was not received")
//                completion(.failure(.noData))
//                return
//            }
//            
//            
//            
//            do {
//                self.bearer = try JSONDecoder().decode(Bearer.self, from: data)
//
//            } catch {
//                print("Error decoding Data: \(error)")
//                completion(.failure(.noData))
//            }
//
//            self.classListings.append(classListing)
//            completion(.success(true))
//
//
//
//        }.resume()
        
//    }//
    
    
    func fetchClassFromServer() {
        
        
    }//
    
    
    // MARK: - Update Class Server
    
    func updateClass() {
       
        
    }//
    
    
    
    
    // MARK: Delete From The Server
    
    func deleteClass() {
        
    }
    
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
    
}
