//
//  ClassDetailViewController.swift
//  AnywhereFitness
//
//  Created by Norlan Tibanear on 8/23/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class ClassDetailViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var instructorLabel: UILabel!
    @IBOutlet weak var intensityLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var attendeesTextView: UITextView!
    @IBOutlet weak var maxClassSizeLabel: UILabel!
    
    @IBOutlet weak var smallViewLeft: UIView!
    @IBOutlet weak var smallViewCenter: UIView!
    @IBOutlet weak var smallViewRight: UIView!
    
    
    
    // MARK: - Properties
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
    }
    
    func configureView() {
        smallViewLeft.layer.cornerRadius = 8
        smallViewLeft.layer.borderWidth = 1
        smallViewLeft.layer.borderColor = UIColor.lightGray.cgColor
        smallViewLeft.clipsToBounds = true
        
        smallViewCenter.layer.cornerRadius = 8
        smallViewCenter.layer.borderWidth = 1
        smallViewCenter.layer.borderColor = UIColor.lightGray.cgColor
        smallViewCenter.clipsToBounds = true
        
        smallViewRight.layer.cornerRadius = 8
        smallViewRight.layer.borderWidth = 1
        smallViewRight.layer.borderColor = UIColor.lightGray.cgColor
        smallViewRight.clipsToBounds = true
    }
    


} // CLASS
