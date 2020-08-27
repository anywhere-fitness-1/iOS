//
//  InstructorNameViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_loaner_226 on 8/26/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class InstructorNameViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var passingInstructor: Instructor?
    var toInstructorUsernameViewController = "ToInstructorUsernameViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toInstructorUsernameViewController {
            let usernameVC = segue.destination as? InstructorUsernameViewController
            usernameVC?.passingInstructor = passingInstructor
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let name = nameTextField.text,
            !name.isEmpty else { return }
        
        let instructor = Instructor(username: nil, password: nil, name: name, specialties: nil, image: nil)
        
        passingInstructor = instructor
        
    }
}
