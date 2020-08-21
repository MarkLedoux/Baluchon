//
//  Main.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 20/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

// MARK: - Main Data
struct Main: Codable {
	let temp: Double?
	let feelsLike: Double?
	let tempMin: Double?
	let tempMax: Double?
	let pressure: Int?
	let humidity: Int?
}

// MARK: - Main Data Keys
private enum CodingKeys: String, CodingKey {
	case temp, pressure, humidity
	case feelsLike = "feels_like"
	case tempMin = "temp_min"
	case tempMax = "temp_max"
}
