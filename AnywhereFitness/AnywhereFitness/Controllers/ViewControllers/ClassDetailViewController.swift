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
    
    @IBOutlet weak var topBackgroundView: UIView!
    @IBOutlet weak var centerBackgroundView: UIView!
    @IBOutlet weak var bottomBackgroundView: UIView!
    @IBOutlet weak var locationView: UIView!
    
    @IBOutlet weak var smallViewLeft: UIView!
    @IBOutlet weak var smallViewCenter: UIView!
    @IBOutlet weak var smallViewRight: UIView!
    
    
    
    // MARK: - Properties
    let customUI = CustomUI()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
    }
    
    func configureView() {
        customUI.customCardView(card: topBackgroundView)
        customUI.customCardView(card: centerBackgroundView)
        customUI.customCardView(card: bottomBackgroundView)
        
        customUI.customSmallCardView(card: smallViewLeft)
        customUI.customSmallCardView(card: smallViewCenter)
        customUI.customSmallCardView(card: smallViewRight)
        
        locationView.layer.borderWidth = 1
        locationView.layer.borderColor = UIColor.white.cgColor
    }
    


} // CLASS
