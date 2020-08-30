//
//  LoginController.swift
//  AnywhereFitness
//
//  Created by Cora Jacobson on 8/25/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case noData
    case failedSignUp
    case failedSignIn
    case noToken
    case tryAgain
    case failedDecoding
    case failedEncoding
    case failedResponse
    case noIdentifier
    case noRep
    case otherError
}

class LoginController {
    
    static let shared = LoginController()
    
    private init() { }
    
    var currentUser: User?
    
    private let firebaseURL = URL(string: "https://fitness-bd254.firebaseio.com/users/")!
    
    // MARK: - Get User
    
//    func getUser(with identifier: String, completion: @escaping (Result<User, NetworkError>) -> Void) {
//
//        let requestURL = firebaseURL.appendingPathComponent(identifier).appendingPathExtension("json")
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = HTTPMethod.get.rawValue
//        
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                print("Get user failed with error: \(error)")
//                completion(.failure(.otherError))
//                return
//            }
//            guard let response = response as? HTTPURLResponse,
//                response.statusCode == 200 else {
//                    print("Get user was unsuccessful")
//                    completion(.failure(.failedResponse))
//                    return
//            }
//            guard let data = data else {
//                print("Data was not received")
//                completion(.failure(.noData))
//                return
//            }
//            do {
//                let user = try JSONDecoder().decode(User.self, from: data)
//                completion(.success(user))
//            } catch {
//                print("Error decoding user: \(error)")
//                completion(.failure(.noData))
//            }
//        }
//        task.resume()
//    }
        
    
    func getImage(imageUrl: URL, completion: @escaping (UIImage?) -> Void) {
        let request = URLRequest(url: imageUrl)
        
        if let urlResponse = URLCache.shared.cachedResponse(for: request) {
            let profileImage = UIImage(data: urlResponse.data)
            completion(profileImage)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error retrieving profile image: \(error)")
                completion(nil)
                return
            }
            
            if let data = data, let response = response {
                let cachedResponse = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cachedResponse, for: request)
                let profileImage = UIImage(data: data)
                completion(profileImage)
                return
            }
        }.resume()
    }
    
    func setCurrentUser(completion: @escaping (User) -> Void) {
        if let identifier = Auth.auth().currentUser?.uid {
            Database.database().reference().child("users").child(identifier).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                if let username = value?["username"] as? String,
                    let name = value?["name"] as? String,
                    let about = value?["about"] as? String,
                    let imageString = value?["profileImageUrl"] as? String,
                    let imageURL = URL(string: imageString),
                    let isInstructor = value?["isInstructor"] as? Bool {
                    let user = User(identifier: identifier, username: username, name: name, about: about, image: imageURL, isInstructor: isInstructor)
                    completion(user)
                }
            })
        }
    }
    
    func getUser(with identifier: String, completion: @escaping (User) -> Void) {
        Database.database().reference().child("users").child(identifier).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            if let username = value?["username"] as? String,
                let name = value?["name"] as? String,
                let about = value?["about"] as? String,
                let imageString = value?["profileImageUrl"] as? String,
                let imageURL = URL(string: imageString),
                let isInstructor = value?["isInstructor"] as? Bool {
                let user = User(identifier: identifier, username: username, name: name, about: about, image: imageURL, isInstructor: isInstructor)
                completion(user)
            }
        })
    }

//    private func postRequest(for url: URL) -> URLRequest {
//        var request = URLRequest(url: url)
//        request.httpMethod = HTTPMethod.post.rawValue
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        return request
//    }
    
//    // MARK: - Sign Up Functions
//
//    func clientSignUp(with client: Client, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
//        var request = postRequest(for: clientSignUpURL)
//        do {
//            let jsonData = try JSONEncoder().encode(client)
//            request.httpBody = jsonData
//            let task = URLSession.shared.dataTask(with: request) { (_, response, error) in
//                if let error = error {
//                    print("SignUp failed with error: \(error)")
//                    completion(.failure(.failedSignUp))
//                    return
//                }
//                guard let response = response as? HTTPURLResponse,
//                    response.statusCode == 200 else {
//                        print("Sign up was unsuccesful")
//                        completion(.failure(.failedSignUp))
//                        return
//                }
//                completion(.success(true))
//            }
//            task.resume()
//        } catch {
//            print("Error encoding client: \(error)")
//            completion(.failure(.failedSignUp))
//        }
//    }
//
//    func instructorSignUp(with instructor: Instructor, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
//        var request = postRequest(for: instructorSignUpURL)
//        do {
//            let jsonData = try JSONEncoder().encode(instructor)
//            request.httpBody = jsonData
//            let task = URLSession.shared.dataTask(with: request) { (_, response, error) in
//                if let error = error {
//                    print("SignUp failed with error: \(error)")
//                    completion(.failure(.failedSignUp))
//                    return
//                }
//                guard let response = response as? HTTPURLResponse,
//                    response.statusCode == 200 else {
//                        print("Sign up was unsuccesful")
//                        completion(.failure(.failedSignUp))
//                        return
//                }
//                completion(.success(true))
//            }
//            task.resume()
//        } catch {
//            print("Error encoding instructor: \(error)")
//            completion(.failure(.failedSignUp))
//        }
//    }
//
//
//    // MARK: - Login Functions
//
//    func clientLogin(with client: Client, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
//        var request = postRequest(for: clientsLoginURL)
//        do {
//            let jsonData = try JSONEncoder().encode(client)
//            request.httpBody = jsonData
//            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//                if let error = error {
//                    print("Sign in failed with error: \(error)")
//                    completion(.failure(.failedSignIn))
//                    return
//                }
//                guard let response = response as? HTTPURLResponse,
//                    response.statusCode == 200 else {
//                        print("Sign in was unsuccessful")
//                        completion(.failure(.failedSignIn))
//                        return
//                }
//                guard let data = data else {
//                    print("Data was not received")
//                    completion(.failure(.noData))
//                    return
//                }
//                do {
//                    self.bearer = try JSONDecoder().decode(Bearer.self, from: data)
//                    completion(.success(true))
//                } catch {
//                    print("Error decoding bearer: \(error)")
//                    completion(.failure(.noToken))
//                }
//            }
//            task.resume()
//        } catch {
//            print("Error encoding client: \(error.localizedDescription)")
//            completion(.failure(.failedSignIn))
//        }
//    }
//
//    func instructorLogin(with instructor: Instructor, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
//        var request = postRequest(for: instructorsLoginURL)
//        do {
//            let jsonData = try JSONEncoder().encode(instructor)
//            request.httpBody = jsonData
//            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//                if let error = error {
//                    print("Sign in failed with error: \(error)")
//                    completion(.failure(.failedSignIn))
//                    return
//                }
//                guard let response = response as? HTTPURLResponse,
//                    response.statusCode == 200 else {
//                        print("Sign in was unsuccessful")
//                        completion(.failure(.failedSignIn))
//                        return
//                }
//                guard let data = data else {
//                    print("Data was not received")
//                    completion(.failure(.noData))
//                    return
//                }
//                do {
//                    self.bearer = try JSONDecoder().decode(Bearer.self, from: data)
//                    completion(.success(true))
//                } catch {
//                    print("Error decoding bearer: \(error)")
//                    completion(.failure(.noToken))
//                }
//            }
//            task.resume()
//        } catch {
//            print("Error encoding instructor: \(error.localizedDescription)")
//            completion(.failure(.failedSignIn))
//        }
//    }
    
}
