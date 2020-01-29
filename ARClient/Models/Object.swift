//
//  Object.swift
//  ARClient
//
//  Created by Георгий Кашин on 29.01.2020.
//  Copyright © 2020 Georgii Kashin. All rights reserved.
//

import Foundation

struct Object: Codable {
    let id: Int?
    let userId: Int
    let url: URL
    let date: Date
}
