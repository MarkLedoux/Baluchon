//
//  Clouds.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 15/05/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

// MARK: - Clouds Data
struct Clouds: Codable { 
	var all: Int? 
}

// MARK: - Clouds Data Keys
private enum CodingKeys: String, CodingKey { 
	case all
}
