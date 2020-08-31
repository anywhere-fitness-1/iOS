//
//  ClassRepresentation.swift
//  AnywhereFitness
//
//  Created by Cora Jacobson on 8/20/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import Foundation

struct ClassRepresentation: Codable {

    var identifier: String
    var classTitle: String
    var classType: String
    var instructorID: String
    var startTime: Date
    var duration: String
    var intensity: String
    var location: String
    var maxClassSize: Int
    var attendees: String
}
