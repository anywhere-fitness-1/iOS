//
//  InstructorPhotoViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_loaner_226 on 8/26/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class InstructorPhotoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveAndFinishButton: UIButton!
    
    var passingInstructor: Instructor?
    var toInstructorUsernameViewController = "ToInstructorUsernameViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func saveAndFinishButtonTapped(_ sender: UIButton) {
        guard let image = imageView else { return }
        
//        let instructor = Instructor(username: passingInstructor?.username, password: passingInstructor?.password, name: passingInstructor?.name, specialties: passingInstructor?.specialties, image: image)
//        
//        passingInstructor = instructor
    }
    
    
}
