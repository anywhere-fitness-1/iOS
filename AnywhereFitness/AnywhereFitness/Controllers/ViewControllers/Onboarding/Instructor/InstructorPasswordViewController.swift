//
//  InstructorPasswordViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_loaner_226 on 8/26/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class InstructorPasswordViewController: UIViewController {

    @IBOutlet weak var createPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var passingInstructor: Instructor?
    var toInstructorPhotoViewController = "ToInstructorPhotoViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toInstructorPhotoViewController {
            let photoVC = segue.destination as? InstructorPhotoViewController
            photoVC?.passingInstructor = passingInstructor
        }
    }
    

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let password = createPasswordTextField.text,
            !password.isEmpty else { return }
        
        let instructor = Instructor(username: passingInstructor?.username, password: password, name: passingInstructor?.name, specialties: passingInstructor?.specialties, image: nil)
        
        passingInstructor = instructor
    }
}
