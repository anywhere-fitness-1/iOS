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
    var toInstructorMoreInfoViewController = "ToInstructorMoreInfoViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        <#code#>
    }
    
    
    
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
    }
    
}
