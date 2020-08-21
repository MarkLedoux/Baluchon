//
//  WeatherResultContainer.swift
//  BaluchonTests
//
//  Created by Mark LEDOUX on 11/08/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

/// Class with delegate to update the UITableView after the network request completes
class WeatherResultContainer {
	weak var delegate: WeatherResultContainerDelegate?
	
	init(weatherResult: WeatherResult, imageData: Data? = nil) {
		self.weatherResult = weatherResult
		self.imageData = imageData
	}
	
	let weatherResult: WeatherResult
	var imageData: Data? {
		didSet { 
			delegate?.didUpdateImageData()
		}
	}
}
