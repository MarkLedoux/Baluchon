//
//  WeatherTableViewDelegate.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 11/05/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

// swiftlint:disable force_cast
extension WeatherTableViewController: UITableViewDataSource {
	// MARK: - Methods

	func numberOfSections(in tableView: UITableView) -> Int {
		return weatherResult?.name.count ?? 0
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return weatherResult?.name.count ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherCell

		guard let weatherResult = weatherResult else { return UITableViewCell() }
		let mainWeather = weatherResult.main.temp
		let weatherWeather = weatherResult.weather.map { (result) -> WeatherElement in
			let weathersWeather = result
			return weathersWeather
		}

		cell.temperatureLabel.text = mainWeather.description
		cell.weatherDescriptionLabel.text = weatherWeather[indexPath.row].description.description
		cell.cityNameLabel.text = weatherResult.name.description
		cell.weatherImageLabel.image = UIImage(named: "sleet")
		return cell
	}
}

extension WeatherTableViewController: UITableViewDelegate { }

extension WeatherTableViewController: WeatherDelegate {
	func didGetWeatherData(weatherResult: WeatherResult) {
		self.weatherResult = weatherResult
	}
}
