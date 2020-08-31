//
//  SettingsViewController.swift
//  AnywhereFitness
//
//  Created by John McCants on 8/20/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

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
    var userNameLabel: UILabel = UILabel()
    var userNameTextField: UITextField = UITextField()
    var nameTextLabel: UILabel = UILabel()
    var nameTextField: UITextField = UITextField()
    var logoutButton: UIButton = UIButton(type: .roundedRect)
    var aboutLabel: UILabel = UILabel()
    var profileImageView: UIImageView = UIImageView()
    var editPhotoView: UIImageView = UIImageView()
    var grayPhotoView: UIImageView = UIImageView()
    var aboutTextView: UITextView = UITextView()

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
        userNameLabel.text = "Username"
        userNameTextField.text = LoginController.shared.currentUser?.username
        nameTextLabel.text = "Name"
        nameTextField.text = LoginController.shared.currentUser?.name
        aboutLabel.text = "About"
        aboutTextView.text = LoginController.shared.currentUser?.about
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        print("setEditing")
        if editing {
        wasEdited = true
        editPhotoView.isHidden = false
        grayPhotoView.isHidden = false
        isUserInteractionEnabled(bool: true)
        } else {
            self.resignFirstResponder()
            guard let username = userNameTextField.text, !username.isEmpty else {
                showAlert(text: "username")
                return}
            guard let name = nameTextField.text, !name.isEmpty else {
                showAlert(text: "name")
                return
            }
            userNameTextField.text = username
            nameTextField.text = name
            grayPhotoView.isHidden = true
            editPhotoView.isHidden = true
            //Update User Info here
        }
    }

    func addSubview() {
        scrollView.addSubview(containerView)
        containerView.addSubview(nameTextField)
        containerView.addSubview(userNameLabel)
        containerView.addSubview(nameTextLabel)
        containerView.addSubview(logoutButton)
        containerView.addSubview(aboutLabel)
        containerView.addSubview(userNameTextField)
        containerView.addSubview(profileImageView)
        containerView.addSubview(aboutTextView)
        profileImageView.addSubview(grayPhotoView)
        profileImageView.addSubview(editPhotoView)
    }

    func isUserInteractionEnabled(bool: Bool) {
        if bool == true {
            userNameTextField.isUserInteractionEnabled = true
            nameTextField.isUserInteractionEnabled = true
            profileImageView.isUserInteractionEnabled = true
            editPhotoView.isUserInteractionEnabled = true
            grayPhotoView.isUserInteractionEnabled = true
            aboutTextView.isUserInteractionEnabled = true

        } else {
        userNameTextField.isUserInteractionEnabled = false
        nameTextField.isUserInteractionEnabled = false
        profileImageView.isUserInteractionEnabled = false
        editPhotoView.isUserInteractionEnabled = false
        grayPhotoView.isUserInteractionEnabled = false
        aboutTextView.isUserInteractionEnabled = false
        }
    }

    func firstNameTextFieldConfiguration() {
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.borderStyle = .roundedRect
    }

    func lastNameTextFieldConfiguration() {
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.borderStyle = .roundedRect
    }

    func nameLabelsConfiguration() {
        userNameLabel.font = UIFont.boldSystemFont(ofSize: userNameLabel.font.pointSize)
        nameTextLabel.font = UIFont.boldSystemFont(ofSize: nameTextLabel.font.pointSize)
    }
    func aboutLabelConfiguration() {
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.text = "About"
        aboutLabel.font = UIFont.boldSystemFont(ofSize: aboutLabel.font.pointSize)
    }

    func aboutTextViewConfiguration() {
        aboutTextView.translatesAutoresizingMaskIntoConstraints = false
        aboutTextView.text = "Hey I'm John and I like to workout. Sally sells shells by the sea shore"
        aboutTextView.clipsToBounds = true
        aboutTextView.font = nameTextField.font
    }

    func logOutButtonConfiguration() {
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.titleLabel?.text = "Logout"
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        logoutButton.backgroundColor = .black
        logoutButton.layer.cornerRadius = 5
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }

    func profileImageViewConfiguration() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = UIImage(named: "placeholder")
        profileImageView.layer.borderWidth = 1.0
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderColor = UIColor.darkGray.cgColor
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        editPhotoView.addGestureRecognizer(tapGestureRecognizer2)
        grayPhotoView.addGestureRecognizer(tapGestureRecognizer)
        profileImageView.setRounded()
    }

    func containerViewConfiguration() {
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(tapGestureRecognizer:)))
        containerView.addGestureRecognizer(tapGestureRecognizer2)
        containerView.isUserInteractionEnabled = true
        editPhotoView.translatesAutoresizingMaskIntoConstraints = false
        editPhotoView.image = UIImage(named: "addPhoto")
        editPhotoView.clipsToBounds = true
        grayPhotoView.translatesAutoresizingMaskIntoConstraints = false
        grayPhotoView.image = UIImage(named: "GrayPhoto")
        grayPhotoView.clipsToBounds = true
    }

    func stackViewConfiguration() {
        // Adding The Fields and Labels to a Vertical StackView
          let stackView = UIStackView(arrangedSubviews: [userNameLabel, userNameTextField, nameTextLabel, nameTextField, aboutLabel])
          stackView.axis = .vertical
          stackView.distribution = .equalSpacing
          stackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(stackView)
        let svTop = stackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20)
          let svLeading = stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let svTrailing = stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
          let svHeight = stackView.heightAnchor.constraint(equalToConstant: 180)
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
        logoutButton.topAnchor.constraint(equalTo: aboutTextView.bottomAnchor, constant: 20).isActive = true
        logoutButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        logoutButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        aboutTextView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5).isActive = true
        aboutTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        aboutTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        aboutTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    func setUpViews() {
        navigationItem.rightBarButtonItem = editButtonItem
        //Adding properties to subviews
        view.addSubview(scrollView)
        addSubview()
        isUserInteractionEnabled(bool: false)
        firstNameTextFieldConfiguration()
        lastNameTextFieldConfiguration()
        nameLabelsConfiguration()
        aboutLabelConfiguration()
        logOutButtonConfiguration()
        profileImageViewConfiguration()
        containerViewConfiguration()
        stackViewConfiguration()
        aboutTextViewConfiguration()
    }

    @objc func logoutButtonTapped() { 
        do {
                try Auth.auth().signOut()
            } catch let logoutError {
                print(logoutError)
                presentAFAlertOnMainThread(title: "OOPS!", message: "Something went wrong. \nPlease try again later.", buttonTitle: "Ok")
            }
            dismiss(animated: true, completion: nil)
    }

    func showAlert(text: String) {
        let alert = UIAlertController(title: "Unable to Update", message: "Make sure all fields are filled out", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        switch text {
        case "username":
            alert.message = "Fill out username"
            self.present(alert, animated: true) {
                self.viewDidLoad()
            }
        case "name":
            alert.message = "Fill out name"
            self.present(alert, animated: true) {
                self.viewDidLoad()
            }
        default:
            break
        }
    }

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
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

extension SettingsViewController: UITextFieldDelegate {
}

extension SettingsViewController: UIImagePickerControllerDelegate {
// MARK: - UIImagePickerControllerDelegate Methods
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
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
        self.layer.cornerRadius = (self.frame.width / 2)
        self.layer.masksToBounds = true
        self.contentMode = .scaleAspectFill
    }
}
