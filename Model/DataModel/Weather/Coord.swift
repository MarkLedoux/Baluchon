//
//  Coord.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 15/05/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

struct Coord: Codable { 
	var lat: Double? 
	var lon: Double? 
	
	private enum CodingKeys: String, CodingKey { 
		case lat, lon
	}
}
