//
//  Sys.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 13/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

/// defining sys and its keys 
struct Sys: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise, sunset: Int
}

private enum CodingKeys: String, CodingKey {
    case type, id, country, sunrise, sunset

}
