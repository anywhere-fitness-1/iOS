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
import FirebaseAuth
import FirebaseDatabase

class ClassController {
    static let shared = ClassController()

    private init() { }

    var userClasses: [ClassListing]?
    private let firebaseURL = URL(string: "https://anywherefitness-ba403.firebaseio.com/classes")!

    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void

    // MARK: - Firebase Server Networking
    func getClasses(completion: @escaping CompletionHandler) {
            let requestURL = firebaseURL.appendingPathExtension("json")
            var request = URLRequest(url: requestURL)
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
        classListing.attendees = representation.attendees
    }

    private func updateClasses(with representations: [ClassRepresentation]) throws {
        let context = CoreDataStack.shared.container.newBackgroundContext()
        let identifiersToFetch = representations.compactMap({UUID(uuidString: $0.identifier)})
        let representationsByID = Dictionary(uniqueKeysWithValues: zip(identifiersToFetch, representations))
        var classesToCreate = representationsByID
        let fetchRequest: NSFetchRequest<ClassListing> = ClassListing.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "identifier IN %@", identifiersToFetch)
        let deleteFetchRequest: NSFetchRequest<ClassListing> = ClassListing.fetchRequest()
        deleteFetchRequest.predicate = NSPredicate(format: "NOT (identifier IN %@)", identifiersToFetch)
        context.performAndWait {
            do {
                let existingClasses = try context.fetch(fetchRequest)
                for classEntry in existingClasses {
                    guard let identifier = classEntry.identifier,
                        let representation = representationsByID[identifier] else {
                            continue }
                    update(classListing: classEntry, representation: representation)
                    classesToCreate.removeValue(forKey: identifier)
                }
                for representation in classesToCreate.values {
                    ClassListing(classRepresentation: representation, context: context)
                }
                let classesToDelete = try context.fetch(deleteFetchRequest)
                for classEntry in classesToDelete {
                    context.delete(classEntry)
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
        let task = URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print("Error PUTting class to server: \(error)")
                completion(.failure(.otherError))
                return
            }
            completion(.success(true))
        }
        task.resume()
    }

    // MARK: - FirebaseAuth and FirebaseDatabase Functions

    let ref = Database.database().reference()

    func deleteClass(classListing: ClassListing) {
        if let classID = classListing.identifier?.uuidString {
            ref.child("classes").child(classID).removeValue()
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

    func unRegister(classListing: ClassListing) {
        if let identifier = Auth.auth().currentUser?.uid,
            var attendees = classListing.attendees {
            var attendeeArray = (attendees.components(separatedBy: ", ")).map { $0 }
            if let index = attendeeArray.firstIndex(of: identifier) {
                attendeeArray.remove(at: index)
            }
            attendees = (attendeeArray.map {$0}).joined(separator: ", ")
            updateValue(classListing: classListing, key: "attendees", value: attendees)
        }
    }

    func register(classListing: ClassListing) {
        if let identifier = Auth.auth().currentUser?.uid,
            let attendees = classListing.attendees {
            let newAttendees = attendees + ", \(identifier)"
            updateValue(classListing: classListing, key: "attendees", value: newAttendees)
        }
    }

    private func updateValue(classListing: ClassListing, key: String, value: String) {
        if let classID = classListing.identifier?.uuidString {
            ref.child("classes").child(classID).updateChildValues(["\(key)": value])
            ClassController.shared.getClasses { (_) in
            }
        }
    }

    func getAttendees(classListing: ClassListing, completion: @escaping (String) -> Void) {
        guard let attendeeString = classListing.attendees  else { return }
        let bgQueue = DispatchQueue(label: "bgQueue")
        bgQueue.async {
            let dispatchGroup = DispatchGroup()
            var attendeeNameArray: [String] = []
            let attendeeArray = (attendeeString.components(separatedBy: ", ")).map { $0 }
            for attendeeID in attendeeArray {
                dispatchGroup.enter()
                LoginController.shared.getUser(with: attendeeID) { (user) in
                    attendeeNameArray.append(user.name ?? "")
                    dispatchGroup.leave()
                }
            }
            dispatchGroup.wait()
            completion((attendeeNameArray.map {$0}).joined(separator: ", "))
        }
    }

    func getUserClasses(completion: @escaping ([ClassListing]) -> Void) {
        if let userID = Auth.auth().currentUser?.uid {
            let context = CoreDataStack.shared.mainContext
            let fetchRequest = NSFetchRequest<ClassListing>(entityName: "ClassListing")
            fetchRequest.predicate = NSPredicate(format: "%@ IN attendees", userID)
            do {
                let userClasses = try context.fetch(fetchRequest)
                completion(userClasses)
            } catch {
                print("Error fetching user's classes: \(error)")
            }
        }
    }

}
