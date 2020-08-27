//
//  ClientNameViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_loaner_226 on 8/26/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class ClientNameViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var passingClient: Client?
    var toClientUsernameViewController = "ToClientUsernameViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toClientUsernameViewController {
            let clientInfoVC = segue.destination as? ClientUsernameViewController
            clientInfoVC?.passingClient = passingClient
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let name = nameTextField.text,
            !name.isEmpty else { return }
        
        let client = Client(username: nil, password: nil, name: name, about: nil, image: nil)
        passingClient = client
    }
    
}
