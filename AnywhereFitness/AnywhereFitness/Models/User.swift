//
//  User.swift
//  AnywhereFitness
//
//  Created by Cora Jacobson on 8/28/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import Foundation

struct User: Codable {
    let identifier: String?
    let username: String?
    let password: String?
    var name: String?
    var about: String?
    var image: String?
    var isInstructor: Bool = false
}
