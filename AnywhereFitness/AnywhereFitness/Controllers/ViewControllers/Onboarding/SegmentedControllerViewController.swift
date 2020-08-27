//
//  SegmentedControllerViewController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_loaner_226 on 8/26/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class SegmentedControllerViewController: UIViewController {
    
    enum TypeOfUser {
        case client
        case instructor
    }
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var nextButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func chooseUser() {
        
        if segmentedController.selectedSegmentIndex == 0 {
            
        }
        
    }
    
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
    }
}
