//
//  ClientPasswordViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_loaner_226 on 8/26/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class ClientPasswordViewController: UIViewController {

    @IBOutlet weak var createPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var passingClient: Client?
    var toClientPhotoViewController = "ToClientPhotoViewController"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toClientPhotoViewController {
            let photoVC = segue.destination as? ClientPhotoViewController
            photoVC?.passingClient = passingClient
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let password = createPasswordTextField.text,
            !password.isEmpty else { return }
        
        let client = Client(username: passingClient?.username, password: nil, name: passingClient?.name, about: passingClient?.about, image: nil)
        
        passingClient = client
    }
}
