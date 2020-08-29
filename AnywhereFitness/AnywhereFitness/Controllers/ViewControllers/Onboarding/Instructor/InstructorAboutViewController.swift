//
//  InstructorMoreInfoViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_loaner_226 on 8/26/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class InstructorAboutViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
    var passingInstructor: Instructor?
    var toInstructorPasswordViewController = "ToInstructorPasswordViewController"

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toInstructorPasswordViewController {
            let passwordVC = segue.destination as? InstructorPasswordViewController
            passwordVC?.passingInstructor = passingInstructor
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let specialties = textView.text else { return }
        
        let instructor = Instructor(username: passingInstructor?.username, password: nil, name: passingInstructor?.name, specialties: specialties, image: nil)
        
        passingInstructor = instructor
    }
    
}
