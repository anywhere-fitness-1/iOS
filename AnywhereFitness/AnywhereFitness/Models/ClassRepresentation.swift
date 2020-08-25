//
//  ClassRepresentation.swift
//  AnywhereFitness
//
//  Created by Cora Jacobson on 8/20/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import Foundation

struct ClassRepresentation: Codable {
    
    var uuid: String
    var id: Int
    var name: String
    var type: String
    var instructorID: Int
    var date: String
    var startTime: String
    var duration: Int
    var intensity: String
    var location: String
    var maxClassSize: Int
    var attendeeCount: Int
    var attendees: [Int]
    
}
