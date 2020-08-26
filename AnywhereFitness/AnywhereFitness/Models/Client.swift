//
//  Client.swift
//  AnywhereFitness
//
//  Created by Cora Jacobson on 8/25/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import Foundation

struct Client: Codable {
    let username: String
    let password: String
    let name: String
    let about: String
    let image: String
}
