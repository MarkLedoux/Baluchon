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
    let coord: Coord
    let weather: [WeatherElement]
    let base: String
    let main: [String: Double]
    let visibility: Int
    let wind: [String: Double]
    let clouds: [String: Double]
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

/// defining keys for  the weather data 
private enum CodingKeys: String, CodingKey {
    case base, visibility, dt, timezone, id, name, cod
}
