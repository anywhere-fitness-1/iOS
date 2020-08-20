//
//  CustomUI.swift
//  AnywhereFitness
//
//  Created by Lambda_School_loaner_226 on 8/19/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

struct CustomUI {
    
    func customCardView(card: UIView) {
        card.layer.cornerRadius = 10
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowRadius = 10
        card.layer.shadowOpacity = 0.8
        card.layer.shadowOffset = CGSize(width: 10, height: 10)
    }
    
    func customDullButtonCorners(button: UIButton) {
        button.layer.cornerRadius = 10
    }
    
    func customDullButtonCornersWithBorders(button: UIButton) {
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
    }
    
    func customImageCorners(cell: UICollectionViewCell) {
        cell.layer.cornerRadius = 10
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 10
        cell.layer.shadowOpacity = 0.8
        cell.layer.shadowOffset = CGSize(width: 10, height: 10)
    }
}
