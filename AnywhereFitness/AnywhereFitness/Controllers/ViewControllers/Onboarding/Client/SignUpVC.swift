//
//  SignUpVC.swift
//  AnywhereFitness
//
//  Created by Norlan Tibanear on 8/29/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class SignUpVC: UITableViewController {

    // Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var clientInstructorSegmentedControl: UISegmentedControl!
    @IBOutlet weak var signUpButton: UIButton!

    // MARK: - Properties
    var image: UIImage?
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.borderColor = UIColor.darkGray.cgColor
        profileImageView.layer.borderWidth = 2
        aboutTextView.layer.borderWidth = 1
        aboutTextView.layer.borderColor = UIColor.systemGray4.cgColor
        aboutTextView.layer.cornerRadius = 5
        aboutTextView.clipsToBounds = true
        
        updateImage()
    }

    func updateImage() {
        profileImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        profileImageView.addGestureRecognizer(tapGesture)
    }

    @objc func presentPicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }

    @IBAction func signUpBtn(_ sender: UIButton) {

        guard let username = usernameTextField.text, !username.isEmpty else { return }
        guard let name = nameTextField.text, !name.isEmpty else { return }
        guard let email = emailTextField.text, !email.isEmpty else { return }
        guard let password = passwordTextField.text, !password.isEmpty else { return }
        guard let about = aboutTextView.text, !about.isEmpty else { return }

        guard let imageSelected = self.image else {
            print("Image is nil")
            return
        }
        var isInstructor: Bool = false
        switch clientInstructorSegmentedControl.selectedSegmentIndex {
        case 1:
            isInstructor = true
        default:
            isInstructor = false
        }

        guard let imageData = imageSelected.jpegData(compressionQuality: 0.9) else { return }
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in

            if error != nil {
                print(error!.localizedDescription)
                return
            }
            if let authData = authDataResult {
                print(authData.user.email)
                var dict: [String: Any] = [
                    "uid": authData.user.uid,
                    "username": username,
                    "name": name,
                    "email": authData.user.uid,
                    "about": about,
                    "profileImageUrl": "",
                    "isInstructor": isInstructor
                    ]

                let storageRef = Storage.storage().reference(forURL: "gs://anywherefitness-ba403.appspot.com")
                let storageProfileRef = storageRef.child("profile").child(authData.user.uid)

                let metadata = StorageMetadata()
                metadata.contentType = "image/json"

                storageProfileRef.putData(imageData, metadata: metadata, completion: { (_, error) in
                    if error != nil {
                        print(error?.localizedDescription)
                        return
                    }

                    storageProfileRef.downloadURL(completion: { (url, error) in
                        if let metaImageUrl = url?.absoluteString {
                            dict["profileImageUrl"] = metaImageUrl

                            Database.database().reference().child("users").child(authData.user.uid).updateChildValues(dict, withCompletionBlock: { (error, _) in
                                if error == nil {
                                    print("Done")
                                }
                            })
                        }
                    })
                })
            }

        } // Auth
        performSegue(withIdentifier: "gotoTabbarSearchSegue", sender: nil)
//        dismiss(animated: true, completion: nil)
    } // signUpBtn

    @IBAction func userSegmented(_ sender: UISegmentedControl) {

        if sender.selectedSegmentIndex == 0 {
            user?.isInstructor = false
        } else {
            user?.isInstructor = true
        }
    }//

    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

} //

extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        print("Didfinish picking media")

        if let imageSelected = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = imageSelected
            profileImageView.image = imageSelected
        }

        if let imageOriginal = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = imageOriginal
            profileImageView.image = imageOriginal
        }

        picker.dismiss(animated: true, completion: nil)
    }

}//
