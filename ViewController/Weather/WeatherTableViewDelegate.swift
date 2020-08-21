//
//  WeatherTableViewDelegate.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 11/05/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

// swiftlint:disable force_cast
class WeatherTableViewDataSource: NSObject, UITableViewDataSource {
	
	///creating an Array to handle adding multiple cities
	var weatherResults: [WeatherResultContainer] = []
	
	// MARK: - Methods

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return weatherResults.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherCell

		let weatherResult = weatherResults[indexPath.row]
		
		let temp = weatherResult.weatherResult.main?.temp
		let temperature = Temperature(degreesK: temp ?? 0)
		let desc = weatherResult.weatherResult.weather?.first?.main
		let cityName = weatherResult.weatherResult.name
		guard
			let weatherImageData = weatherResult.imageData,
			let weatherImage = UIImage(data: weatherImageData)
		else { return UITableViewCell() }
	
		cell.temperatureLabel.text = "\(Int((temperature.degreesC)))°C"
		cell.weatherDescriptionLabel.text = desc
		cell.cityNameLabel.text = cityName
		
		cell.weatherImage.image = weatherImage
		return cell
	}
}

class WeatherTableViewDelegate: NSObject, UITableViewDelegate { 
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}
