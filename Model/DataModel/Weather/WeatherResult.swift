//
//  Weather.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 13/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

/// defining weather data
struct WeatherResult: Codable {
	let weather: [WeatherElement]
	let base: String
	let main: Main
	let name: String
}

/// defining keys for  the weather data 
private enum CodingKeys: String, CodingKey {
	case base, name
}
