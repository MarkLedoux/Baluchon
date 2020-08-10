//
//  WeatherDelegate.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 14/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

// MARK : - Weather Delegate Protocol
protocol WeatherDelegate: class {
	func didGetWeatherData(weatherResult: WeatherResult)
}
