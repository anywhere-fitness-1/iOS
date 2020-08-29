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
        if let classListing = classListing {
            classLabel.text = classListing.classTitle
            typeLabel.text = classListing.classType
            currentAttendeesLabel.text = "Attendees: \(classListing.attendees?.count)"
            locationLabel.text = classListing.location
            // timeLabel.text
        }
    }
}
