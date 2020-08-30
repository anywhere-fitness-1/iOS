//
//  SearchTableViewCell.swift
//  AnywhereFitness
//
//  Created by Norlan Tibanear on 8/30/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    
    // Outlets
    @IBOutlet weak var classTintView: UIView!
    @IBOutlet weak var classImageView: UIImageView!
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var instructorLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    static let reuseIdentifier = "searchCell"
    
    // MARK: - Properties
    
    private let dateFormatter = DateFormatter()
    private let timeFormatter = DateFormatter()
    
    
    var classListing: ClassListing? {
        didSet {
            updateViews()
            updateClassView()
        }
    }
    
    private func updateViews() {
        guard let classListing = classListing else { return }
        
        classNameLabel.text = classListing.classTitle
        
        locationLabel.text = classListing.location
//        dateLabel.text = classListing.startTime
        
    }
    
    private func updateClassView() {
        guard let classListing = classListing else { return }
        print(classListing)
    }
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
