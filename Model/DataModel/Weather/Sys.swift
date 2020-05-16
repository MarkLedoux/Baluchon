//
//  Sys.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 15/05/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

class Sys: Codable {
	
	var type: Int?
	var id: Int?
	var country: String?
	var sunrise: Int?
	var sunset: Int?
	
	private enum CodingKeys: String, CodingKey {
		
		case type, id, country, sunrise, sunset
	}
}
