//
//  Weather.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 13/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

// MARK: - Weather Data
struct WeatherResult: Codable {
	
	let coord: Coord?
	let weather: [WeatherElement]?
	let base: String?
	let main: Main?
	let visibility: Int? 
	let wind: Wind? 
	let clouds: Clouds? 
	let dt: Int? 
	let sys: Sys? 
	let timezone: Int?
	let name: String?
	let cod: Int? 
}

// MARK: - Weather Data Keys 
private enum CodingKeys: String, CodingKey {
	case coord, weather, base, main, visibility, wind, clouds, dt, sys, timezone, name
	case cod = "code"
}
