//
//  SearchCollectionViewCell.swift
//  AnywhereFitness
//
//  Created by Lambda_School_loaner_226 on 8/20/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var currentAttendeesLabel: UILabel!
    @IBOutlet weak var instructorLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var classListing: ClassListing? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        classLabel.text = classListing?.instructorName
        typeLabel.text = classListing?.classType
        currentAttendeesLabel.text = "Attendees: \(classListing?.attendees ?? 0)"
        locationLabel.text = classListing?.location
        timeLabel.text = "\(classListing?.date)"
        
    }
}
