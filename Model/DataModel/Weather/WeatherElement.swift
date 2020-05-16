//
//  WeatherElement.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 13/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

///defining weatherElement data and its keys 
struct WeatherElement: Codable {
	let id: Int?
	let main, weatherDescription, icon: String?
}

private enum CodingKeys: String, CodingKey {
	case id, main, icon
	case weatherDescription = "description"
}
