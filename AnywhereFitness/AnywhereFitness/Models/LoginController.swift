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
import FirebaseStorage

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
    let ref = Database.database().reference()

    private let firebaseURL = URL(string: "https://fitness-bd254.firebaseio.com/users/")!

    // MARK: - Get User    

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
            ref.child("users").child(identifier).observeSingleEvent(of: .value, with: { (snapshot) in
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
        ref.child("users").child(identifier).observeSingleEvent(of: .value, with: { (snapshot) in
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

    func updateValue(key: String, value: String) {
        if let userID = Auth.auth().currentUser?.uid {
            ref.child("users").child(userID).updateChildValues(["\(key)": value])
        }
    }

}
