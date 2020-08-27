//
//  LoginController.swift
//  AnywhereFitness
//
//  Created by Cora Jacobson on 8/25/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import Foundation

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
    case failedResponse
}

class LoginController {
    
    var bearer: Bearer?
        
    private let baseURL = URL(string: "https://anywhere-fitness-1.herokuapp.com/api")!
    private lazy var clientSignUpURL = baseURL.appendingPathComponent("/clients/register")
    private lazy var instructorSignUpURL = baseURL.appendingPathComponent("/instructors/register")
    private lazy var clientsLoginURL = baseURL.appendingPathComponent("/clients/login")
    private lazy var instructorsLoginURL = baseURL.appendingPathComponent("/instructors/login")
    
    
    private func postRequest(for url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    // MARK: - Sign Up Functions
    
    func clientSignUp(with client: Client, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        var request = postRequest(for: clientSignUpURL)
        do {
            let jsonData = try JSONEncoder().encode(client)
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { (_, response, error) in
                if let error = error {
                    print("SignUp failed with error: \(error)")
                    completion(.failure(.failedSignUp))
                    return
                }
                guard let response = response as? HTTPURLResponse,
                    response.statusCode == 200 else {
                        print("Sign up was unsuccesful")
                        completion(.failure(.failedSignUp))
                        return
                }
                completion(.success(true))
            }
            task.resume()
        } catch {
            print("Error encoding client: \(error)")
            completion(.failure(.failedSignUp))
        }
    }
    
    func instructorSignUp(with instructor: Instructor, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        var request = postRequest(for: instructorSignUpURL)
        do {
            let jsonData = try JSONEncoder().encode(instructor)
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { (_, response, error) in
                if let error = error {
                    print("SignUp failed with error: \(error)")
                    completion(.failure(.failedSignUp))
                    return
                }
                guard let response = response as? HTTPURLResponse,
                    response.statusCode == 200 else {
                        print("Sign up was unsuccesful")
                        completion(.failure(.failedSignUp))
                        return
                }
                completion(.success(true))
            }
            task.resume()
        } catch {
            print("Error encoding instructor: \(error)")
            completion(.failure(.failedSignUp))
        }
    }
    
    
    // MARK: - Login Functions
    
    func clientLogin(with client: Client, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        var request = postRequest(for: clientsLoginURL)
        do {
            let jsonData = try JSONEncoder().encode(client)
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Sign in failed with error: \(error)")
                    completion(.failure(.failedSignIn))
                    return
                }
                guard let response = response as? HTTPURLResponse,
                    response.statusCode == 200 else {
                        print("Sign in was unsuccessful")
                        completion(.failure(.failedSignIn))
                        return
                }
                guard let data = data else {
                    print("Data was not received")
                    completion(.failure(.noData))
                    return
                }
                do {
                    self.bearer = try JSONDecoder().decode(Bearer.self, from: data)
                    completion(.success(true))
                } catch {
                    print("Error decoding bearer: \(error)")
                    completion(.failure(.noToken))
                }
            }
            task.resume()
        } catch {
            print("Error encoding client: \(error.localizedDescription)")
            completion(.failure(.failedSignIn))
        }
    }
    
    func instructorLogin(with instructor: Instructor, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        var request = postRequest(for: instructorsLoginURL)
        do {
            let jsonData = try JSONEncoder().encode(instructor)
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Sign in failed with error: \(error)")
                    completion(.failure(.failedSignIn))
                    return
                }
                guard let response = response as? HTTPURLResponse,
                    response.statusCode == 200 else {
                        print("Sign in was unsuccessful")
                        completion(.failure(.failedSignIn))
                        return
                }
                guard let data = data else {
                    print("Data was not received")
                    completion(.failure(.noData))
                    return
                }
                do {
                    self.bearer = try JSONDecoder().decode(Bearer.self, from: data)
                    completion(.success(true))
                } catch {
                    print("Error decoding bearer: \(error)")
                    completion(.failure(.noToken))
                }
            }
            task.resume()
        } catch {
            print("Error encoding instructor: \(error.localizedDescription)")
            completion(.failure(.failedSignIn))
        }
    }
    
}
