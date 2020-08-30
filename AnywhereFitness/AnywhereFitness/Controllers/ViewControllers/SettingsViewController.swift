//
//  SettingsViewController.swift
//  AnywhereFitness
//
//  Created by John McCants on 8/20/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var navBar: UINavigationItem!
    var wasEdited = false
    let imagePicker = UIImagePickerController()
    
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .systemGray4
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.frame = self.view.bounds
        
        return view
        
    }()
    
    // Labels, Buttons, Textfields, ImageView
    var firstNameTextField: UITextField = UITextField()
    var lastNameTextField: UITextField = UITextField()
    var firstNameLabel: UILabel = UILabel()
    var lastNameLabel: UILabel = UILabel()
    
    var passwordTextField: UITextField = UITextField()
    var passwordTextLabel: UILabel = UILabel()
    var logoutButton: UIButton = UIButton(type: .roundedRect)
    var emailTextField: UITextField = UITextField()
    var emailLabel: UILabel = UILabel()
    
    var profileImageView: UIImageView = UIImageView()
    var editPhotoView: UIImageView = UIImageView()
    var grayPhotoView: UIImageView = UIImageView()
    
    override func viewWillLayoutSubviews() {
        profileImageView.setRounded()
        editPhotoView.setRounded()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        imagePicker.delegate = self
        currentUser()
        }
    
    private func currentUser() {
        if let imageURL = LoginController.shared.currentUser?.image {
            LoginController.shared.getImage(imageUrl: imageURL, completion: { image in
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                }
            })
        }
        firstNameLabel.text = "Username"
        firstNameTextField.text = LoginController.shared.currentUser?.username
        lastNameLabel.text = "Name"
        lastNameTextField.text = LoginController.shared.currentUser?.name
        emailLabel.text = "About"
        emailTextField.text = LoginController.shared.currentUser?.about
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        if editing {
        wasEdited = true
        editPhotoView.isHidden = false
        grayPhotoView.isHidden = false
        } else {
            
            guard let firstName = firstNameTextField.text, !firstName.isEmpty else {
                showAlert(text: "firstName")
                return}
           
            guard let lastName = lastNameTextField.text, !lastName.isEmpty else {
                showAlert(text: "lastName")
                return
            }
            
            guard let password = passwordTextField.text, !password.isEmpty else {
                showAlert(text: "password")
                return
            }
            
            guard let email = emailTextField.text, !email.isEmpty else {
                showAlert(text: "email")
                return
            }
            firstNameTextField.text = firstName
            lastNameTextField.text = lastName
            emailTextField.text = email
            passwordTextField.text = password
            grayPhotoView.isHidden = true
            editPhotoView.isHidden = true
            
            //Save Information to Core Data
            
            //Save Information to Firebase
        }

        firstNameTextField.isUserInteractionEnabled = editing
        lastNameTextField.isUserInteractionEnabled = editing
        passwordTextField.isUserInteractionEnabled = editing
        emailTextField.isUserInteractionEnabled = editing
        navigationItem.hidesBackButton = editing
        profileImageView.isUserInteractionEnabled = editing
        containerView.isUserInteractionEnabled = editing
        logoutButton.isHidden = editing
        editPhotoView.isUserInteractionEnabled = editing
        grayPhotoView.isUserInteractionEnabled = editing
       

    }
    
    
    func setUpViews() {
        navigationItem.rightBarButtonItem = editButtonItem
        
        //Adding properties to subviews
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(lastNameTextField)
        containerView.addSubview(firstNameLabel)
        containerView.addSubview(lastNameLabel)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(passwordTextLabel)
        containerView.addSubview(logoutButton)
        containerView.addSubview(emailTextField)
        containerView.addSubview(emailLabel)
        containerView.addSubview(firstNameTextField)
        containerView.addSubview(profileImageView)
        profileImageView.addSubview(grayPhotoView)
        profileImageView.addSubview(editPhotoView)
        
        firstNameTextField.isUserInteractionEnabled = false
        lastNameTextField.isUserInteractionEnabled = false
        emailTextField.isUserInteractionEnabled = false
        passwordTextField.isUserInteractionEnabled = false
        profileImageView.isUserInteractionEnabled = false
        editPhotoView.isUserInteractionEnabled = false
        grayPhotoView.isUserInteractionEnabled = false
        
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextField.text = "John"
        firstNameTextField.borderStyle = .roundedRect
        
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.text = "McCants"
        lastNameTextField.borderStyle = .roundedRect
        
        firstNameLabel.text = "First Name"
        firstNameLabel.font = UIFont.boldSystemFont(ofSize:firstNameLabel.font.pointSize)
        lastNameLabel.text = "Last Name"
        lastNameLabel.font = UIFont.boldSystemFont(ofSize: lastNameLabel.font.pointSize)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.text = "123456"
        passwordTextField.borderStyle = .roundedRect
        passwordTextLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextLabel.font = UIFont.boldSystemFont(ofSize: passwordTextLabel.font.pointSize)
        passwordTextLabel.text = "Password"
            
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.borderStyle = .roundedRect
        emailTextField.text = "johnmccants002@gmail.com"
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.text = "Email"
        emailLabel.font = UIFont.boldSystemFont(ofSize: emailLabel.font.pointSize)
            
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.titleLabel?.text = "Logout"
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        logoutButton.backgroundColor = .black
        logoutButton.layer.cornerRadius = 5
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = UIImage(named: "bodypump")
        profileImageView.layer.borderWidth = 1.0
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderColor = UIColor.darkGray.cgColor
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        editPhotoView.addGestureRecognizer(tapGestureRecognizer)
        grayPhotoView.addGestureRecognizer(tapGestureRecognizer)
        profileImageView.setRounded()
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(tapGestureRecognizer:)))
        containerView.addGestureRecognizer(tapGestureRecognizer2)
        containerView.isUserInteractionEnabled = false
        editPhotoView.translatesAutoresizingMaskIntoConstraints = false
        editPhotoView.image = UIImage(named: "addPhoto")
        editPhotoView.clipsToBounds = true
        grayPhotoView.translatesAutoresizingMaskIntoConstraints = false
        grayPhotoView.image = UIImage(named: "GrayPhoto")
        grayPhotoView.clipsToBounds = true
        
        

        // Adding The Fields and Labels to a Vertical StackView
          let stackView = UIStackView(arrangedSubviews: [firstNameLabel, firstNameTextField, lastNameLabel, lastNameTextField, passwordTextLabel, passwordTextField, emailLabel, emailTextField])
          stackView.axis = .vertical
          stackView.distribution = .equalSpacing
          stackView.translatesAutoresizingMaskIntoConstraints = false
          
        containerView.addSubview(stackView)
                 
        let svTop = stackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20)
          let svLeading = stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let svTrailing = stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
          let svHeight = stackView.heightAnchor.constraint(equalToConstant: 250)

        NSLayoutConstraint.activate([svTop, svTrailing, svLeading, svHeight])
        
        profileImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.setRounded()
        
        editPhotoView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        editPhotoView.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
        editPhotoView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        editPhotoView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        editPhotoView.isHidden = true
        editPhotoView.layer.opacity = 0.5
        
        grayPhotoView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20).isActive = true
        grayPhotoView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        grayPhotoView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        grayPhotoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        grayPhotoView.layer.opacity = 0.7
        grayPhotoView.isHidden = true
        grayPhotoView.setRounded()
        
        logoutButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20).isActive = true
        logoutButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        logoutButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
    }
    
    @objc func logoutButtonTapped() {
        let openingController = OpeningViewController()
        present(openingController, animated: true, completion: nil)
        
    }
    
    func showAlert(text: String) {
        let alert = UIAlertController(title: "Unable to Save", message: "Make sure all fields are filled out", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        switch text {
        case "firstName":
            alert.message = "Fill out first name"
            self.present(alert, animated: true) {
                self.viewDidLoad()
            }
        case "lastName":
            alert.message = "Fill out last name"
            self.present(alert, animated: true) {
                self.viewDidLoad()
            }
        case "email":
            alert.message = "Fill out proper email"
            self.present(alert, animated: true) {
                self.viewDidLoad()
            }
        case "password":
            alert.message = "Fill out password"
            self.present(alert, animated: true) {
                self.viewDidLoad()
            }
        default:
            break
        }
        
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)

               // Your action
        print("ImageTapped Function Firing")
           }
    
    @objc func dismissKeyboard(tapGestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    }

extension SettingsViewController : UITextFieldDelegate {
    
}


extension SettingsViewController: UIImagePickerControllerDelegate {
// MARK: - UIImagePickerControllerDelegate Methods
 
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.image = pickedImage
    }
 
    dismiss(animated: true, completion: nil)
}
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension UIImageView {

    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
        self.contentMode = .scaleAspectFill
    }
}


