//
//  InstructorUsernameViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_loaner_226 on 8/26/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class InstructorUsernameViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var passingInstructor: Instructor?
    var toInstructorAboutViewController = "ToInstructorAboutViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toInstructorAboutViewController {
            let aboutVC = segue.destination as? InstructorAboutViewController
            aboutVC?.passingInstructor = passingInstructor
        }
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text,
            !username.isEmpty else { return }
        
        let instructor = Instructor(username: username, password: nil, name: passingInstructor?.name, specialties: nil, image: nil)
        
        passingInstructor = instructor
    }
}
