//
//  CategoryController.swift
//  AnywhereFitness
//
//  Created by Lambda_School_loaner_226 on 8/20/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import Foundation

struct CategoryController {
    
    var categories: [Category] {
        let categoryResults = [
            Category(name: "Aerobics", imageName: "aerobics"),
            Category(name: "BodyPump", imageName: "bodypump"),
            Category(name: "Crossfit", imageName: "crossfit"),
            Category(name: "Cycling", imageName: "cycling"),
            Category(name: "Dancercise", imageName: "dancercise")
        ]
        return categoryResults
    }
    
}
