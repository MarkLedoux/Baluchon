//
//  WeatherElement.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 13/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

// MARK: - WeatherElement Data
struct WeatherElement: Codable {
	let id: Int?
	let main, weatherDescription, icon: String?
}

// MARK: - WeatherElement Data Keys
private enum CodingKeys: String, CodingKey {
	case id, main, icon
	case weatherDescription = "description"
}
