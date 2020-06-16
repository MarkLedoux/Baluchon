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
	
	var weatherResult: WeatherResult?
	
	// MARK: - Methods

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return weatherResult?.weather?.count ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherCell

		guard let weatherResult = weatherResult else { return UITableViewCell() }
		
		let temp = weatherResult.main?.temp
		let desc = weatherResult.weather?.first?.weatherDescription
		let cityName = weatherResult.name
		guard let weatherImage = weatherResult.weather?.first?.icon else { return UITableViewCell() }
		
		// TODO: - Create extension to return the temperatures in celsius? 
		cell.temperatureLabel.text = "\(Int((temp!-273.15)))°C"
		cell.weatherDescriptionLabel.text = desc
		cell.cityNameLabel.text = cityName
		
			guard let url = URL(string: "http://openweathermap.org/img/w/01n.png") else { return UITableViewCell() }
			URLSession.shared.dataTask(with: url) { iconData, _, _ in 
				if let data = iconData { 
					DispatchQueue.main.async {
						cell.weatherImageLabel.image = UIImage(data: data)
					}
				} else { 
					print("Failed to fetch image data")
				}
			}
		cell.weatherImageLabel.image = UIImage(named: weatherImage)
		return cell
	}
}

class WeatherTableViewDelegate: NSObject, UITableViewDelegate { 
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = WeatherDetailViewController()
	}
}
