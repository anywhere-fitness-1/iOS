//
//  Category.swift
//  AnywhereFitness
//
//  Created by Lambda_School_loaner_226 on 8/20/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import UIKit

class Category {
    let name: String
    let imageName: UIImage
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = UIImage(named: imageName)!
    }
    
    
}
