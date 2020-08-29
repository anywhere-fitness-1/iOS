//
//  ClientPhotoViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_loaner_226 on 8/26/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class ClientPhotoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    
    var passingClient: Client?
    var toClientUsernameViewController = "ToClientUsernameViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        // guard let imageView = imageView else { return }
        
        let client = Client(username: passingClient?.username, password: passingClient?.password, name: passingClient?.name, about: passingClient?.about, image: nil)
        
        passingClient = client
        
        
        
    }
    
}
