//
//  Wind.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 15/05/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

class Wind: Codable {
	
	var speed: Double?
	var deg: Int?
	
	private enum CodingKeys: String, CodingKey {
		
		case speed, deg
	}
}
