//
//  ClientUsernameViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_loaner_226 on 8/26/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class ClientUsernameViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        unwrapPassingClient(passingClient: passingClient)
    }
    
    var passingClient: Client?
    var toClientAboutViewController = "ToClientAboutViewController"
    
    func unwrapPassingClient(passingClient: Client?) {
        guard let passingClient = passingClient else { return }
        
         usernameLabel.text = "Hi \(passingClient.name!) Please create a username"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toClientAboutViewController {
            let clientInfoVC = segue.destination as? ClientAboutViewController
            clientInfoVC?.passingClient = passingClient
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text,
            !username.isEmpty else { return }
        
        let client = Client(username: username, password: nil, name: passingClient?.name, about: nil, image: nil)
        
        passingClient = client
        
    }
    
}
