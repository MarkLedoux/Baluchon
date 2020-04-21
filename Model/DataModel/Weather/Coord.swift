//
//  Coord.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 13/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

/// defining coord and its keys 
struct Coord: Codable {
    let lon, lat: Double
}

private enum CodingKeys: String, CodingKey {
    case lon, lat
}
