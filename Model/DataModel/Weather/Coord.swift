//
//  Coord.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 15/05/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

// MARK: - Cord Data
struct Coord: Codable { 
	var lat: Double? 
	var lon: Double? 
}
// MARK: - Cord Data Keys
private enum CodingKeys: String, CodingKey { 
	case lat, lon
}
