//
//  Main.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 20/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

///defining weatherElement data and its keys
struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
}

private enum CodingKeys: String, CodingKey {
    case temp, pressure, humidity
    case feelsLike = "feels_like"
    case tempMin = "temp_min"
    case tempMax = "temp_max"
}
