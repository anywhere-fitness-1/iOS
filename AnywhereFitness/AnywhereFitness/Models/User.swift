//
//  User.swift
//  AnywhereFitness
//
//  Created by Cora Jacobson on 8/28/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import Foundation
import UIKit

struct User: Codable {
    let identifier: String?
    let username: String?
    var name: String?
    var about: String?
    var image: URL
    var isInstructor: Bool = false
}
