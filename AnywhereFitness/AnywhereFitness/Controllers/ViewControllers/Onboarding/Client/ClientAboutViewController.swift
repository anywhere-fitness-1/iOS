//
//  ClientMoreInfoViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_loaner_226 on 8/26/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class ClientAboutViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
    var passingClient: Client?
    var toClientPasswordViewController = "ToClientPasswordViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toClientPasswordViewController {
            let photoVC = segue.destination as? ClientPasswordViewController
            photoVC?.passingClient = passingClient
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let about = textView.text,
            !about.isEmpty else { return }
        
        let client = Client(username: passingClient?.username, password: nil, name: passingClient?.name, about: about, image: nil)
        
        passingClient = client
    }
    
}
