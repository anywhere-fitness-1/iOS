//
//  ClassController.swift
//  AnywhereFitness
//
//  Created by Cora Jacobson on 8/25/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import Foundation
import CoreData

class ClassController {
    
    var bearer: Bearer?
    
    private let baseURL = URL(string: "https://anywhere-fitness-1.herokuapp.com/api")!
    private lazy var getClassesURL = baseURL.appendingPathComponent("/classes")
    private let firebaseURL = URL(string: "https://fitness-bd254.firebaseio.com/")!
    
    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
    
    var classListings: [ClassListing] = []
    
    
    // MARK: - Web Dev Server
    
    func getClasses(completion: @escaping (Result<[ClassListing], NetworkError>) -> Void) {
//        guard let bearer = bearer else {
//            completion(.failure(.noToken))
//            return
//        }
        var request = URLRequest(url: getClassesURL)
        request.httpMethod = HTTPMethod.get.rawValue
//        request.setValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error receiving class data: \(error)")
                completion(.failure(.tryAgain))
                return
            }
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.noToken))
                return
            }
            guard let data = data else {
                print("No data received from getClasses")
                completion(.failure(.noData))
                return
            }
            let jsonDecoder = JSONDecoder()
            do {
                let classes = try jsonDecoder.decode([ClassListing].self, from: data)
                completion(.success(classes))
                
            } catch {
                print("Error decoding class data: \(error)")
                completion(.failure(.tryAgain))
            }
        }
        task.resume()
    }
    
    func createClass() {
        
    }
    
    func updateClass() {
        
    }
    
    func deleteClass() {
        
    }
    
    // MARK: - Firebase Server
    
}
