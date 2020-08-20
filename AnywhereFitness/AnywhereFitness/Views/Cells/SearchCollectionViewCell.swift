//
//  SearchCollectionViewCell.swift
//  AnywhereFitness
//
//  Created by Lambda_School_loaner_226 on 8/20/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var category: Category? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        guard let category = category else { return }
        categoryLabel.text = category.name
        imageView.image = category.imageName
        DispatchQueue.main.async {
            self.imageView.layer.masksToBounds = true
        }
    }
    
}
