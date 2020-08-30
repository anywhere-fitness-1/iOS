//
//  ProfileClassesTableViewCell.swift
//  AnywhereFitness
//
//  Created by Norlan Tibanear on 8/20/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class ProfileClassesTableViewCell: UITableViewCell {
    
    
    // Outlets
    
    
    static let reuseIdentifier = "ProfileCell"
    
    // MARK: - Properties
    
    private let dateFormatter = DateFormatter()
    private let timeFormatter = DateFormatter()
    
    var classListing: ClassListing? {
        didSet {
            updateViews()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func updateViews() {
        guard let classListing = classListing else { return }
        print(classListing)
    }
    
}
