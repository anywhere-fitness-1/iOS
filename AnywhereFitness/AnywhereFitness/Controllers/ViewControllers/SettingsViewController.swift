//
//  SettingsViewController.swift
//  AnywhereFitness
//
//  Created by John McCants on 8/20/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var navBar: UINavigationItem!
    var wasEdited = false
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame = self.view.bounds
        
        return view
        
    }()
    
            // First Name Last Name Properties
              var firstNameTextField: UITextField = UITextField()
              var lastNameTextField: UITextField = UITextField()
              var firstNameLabel: UILabel = UILabel()
              var lastNameLabel: UILabel = UILabel()
              
              // Password Properties
              var passwordTextField: UITextField = UITextField()
              var passwordTextLabel: UILabel = UILabel()
              var logoutButton: UIButton = UIButton(type: .roundedRect)
              var emailTextField: UITextField = UITextField()
              var emailLabel: UILabel = UILabel()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()

        }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        if editing { wasEdited = true } else {
           
            guard let firstName = firstNameTextField.text, !firstName.isEmpty, let lastName = lastNameTextField.text, !lastName.isEmpty, let password = passwordTextField.text, !password.isEmpty, let email = emailTextField.text, !email.isEmpty else {
                showAlert()
                self.viewDidLoad()
                return
            }
            firstNameTextField.text = firstName
            lastNameTextField.text = lastName
            emailTextField.text = email
            passwordTextField.text = password
            
            //Save Information to Core Data
            
            //Save Information to Firebase
        }
        firstNameTextField.isUserInteractionEnabled = editing
        lastNameTextField.isUserInteractionEnabled = editing
        passwordTextField.isUserInteractionEnabled = editing
        emailTextField.isUserInteractionEnabled = editing
        navigationItem.hidesBackButton = editing
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
        
        firstNameTextField.isUserInteractionEnabled = false
        lastNameTextField.isUserInteractionEnabled = false
        emailTextField.isUserInteractionEnabled = false
        passwordTextField.isUserInteractionEnabled = false
        
        
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
        logoutButton.backgroundColor = .blue
        
        
        // Adding The Fields and Labels to a Vertical StackView
          let stackView = UIStackView(arrangedSubviews: [firstNameLabel, firstNameTextField, lastNameLabel, lastNameTextField, passwordTextLabel, passwordTextField, emailLabel, emailTextField, logoutButton])
          stackView.axis = .vertical
          stackView.distribution = .equalSpacing
          stackView.spacing = 10
          stackView.translatesAutoresizingMaskIntoConstraints = false
          
        containerView.addSubview(stackView)
                 
          let svTop = stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20)
          let svLeading = stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15)
          let svWidth = stackView.widthAnchor.constraint(equalToConstant: 200)
          let svHeight = stackView.heightAnchor.constraint(equalToConstant: 500)

        NSLayoutConstraint.activate([svTop, svWidth, svLeading, svHeight])
    }
    
    func logoutButtonTapped(sender: UIButton) {
        
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Unable to Save", message: "Make sure all fields are filled out", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    }

extension SettingsViewController : UITextFieldDelegate {
    
}

