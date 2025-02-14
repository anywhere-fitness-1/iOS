//
//  AFTitleLabel.swift
//  AnywhereFitness
//
//  Created by Norlan Tibanear on 8/31/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class AFTitleLabel: UILabel {

    override init(frame: CGRect) {
           super.init(frame: frame)
           configure()
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

       init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
           super.init(frame: .zero)
           self.textAlignment = textAlignment
           self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
           configure()
       }

       private func configure() {
           textColor = .label
           adjustsFontSizeToFitWidth = true
           minimumScaleFactor = 0.9
           lineBreakMode = .byTruncatingTail
           translatesAutoresizingMaskIntoConstraints = false
       }

}//
