//
//  ClassListing.swift
//  AnywhereFitness
//
//  Created by Cora Jacobson on 8/25/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import Foundation

struct ClassListing: Codable {
    
    var id: Int?
    var name: String
    var type: String
    var time: String
    var date: String
    var duration: String
    var intensity: String
    var location: String
    var attendees: Int
    var maxClassSize: Int
    var instructorID: Int
    
}
