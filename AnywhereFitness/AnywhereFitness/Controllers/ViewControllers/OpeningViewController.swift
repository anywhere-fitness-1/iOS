//
//  OpeningViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_loaner_226 on 8/19/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

class OpeningViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIGestureRecognizerDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var backgroundView: UIView!

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    // MARK: - Functionality Properties
    var player: AVPlayer?
    var customUI = CustomUI()

    // MARK: - Keyboard Properties

    // MARK: - Lifecycle Views
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVideoBackground()
        configureButtons()
        configureTextFields()

        userNameTextField.delegate = self
        passwordTextField.delegate = self

    }

     // Methods or Functions
        func hideKeyBoard() {
            userNameTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
    //        instructorNameTextField.resignFirstResponder()
    //        durationTextField.resignFirstResponder()
    //        maxClassSizeTextField.resignFirstResponder()
        }

        // UITextField Delegates Methods
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            hideKeyBoard()
            return true
        }

    // MARK: - Helper Methods
    func configureVideoBackground() {
        let path = Bundle.main.path(forResource: "AnywhereFitnessOpeningVideo", ofType: "mp4")
        player = AVPlayer(url: NSURL(fileURLWithPath: path!) as URL)
        player!.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.view.layer.insertSublayer(playerLayer, at: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(self.playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player!.currentItem)
        player!.seek(to: CMTime.zero)
        player!.play()
    }

    @objc func playerItemDidReachEnd() {
        player!.seek(to: CMTime.zero)
    }

    func configureButtons() {
        customUI.customDullButtonCorners(button: loginButton)
    }

    func configureTextFields() {
        userNameTextField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }

    @IBAction func createUserButtonTapped(_ sender: UIButton) {

    }

    @IBAction func loginBtn(_ sender: UIButton) {

        guard let email = userNameTextField.text, !email.isEmpty else { return }
        guard let password = passwordTextField.text, !password.isEmpty else { return }

        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            if error != nil {
                print("error")
                return
            }
            LoginController.shared.setCurrentUser { (user) in
                DispatchQueue.main.async {
                    LoginController.shared.currentUser = user
                    ClassController.shared.getUserClasses { (userClasses) in
                        DispatchQueue.main.async {
                            ClassController.shared.userClasses = userClasses
                        }
                    }
                }
            }
        }
    }//

}//
