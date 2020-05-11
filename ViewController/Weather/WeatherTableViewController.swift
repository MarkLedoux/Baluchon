//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 06/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

final class WeatherTableViewController: UIViewController {
	var cities: [WeatherResult] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		setUpNavigationBar()
		setUpWeatherNetworkManager()
		weatherNetWorkManager.loadWeatherData { result in
			switch result {
			case .success:
				print("Successfully fetched weather data")
			case .failure:
				print("Failed to fetch weather data")
			}
		}
	}

	// MARK: - Properties

	private let weatherNetWorkManager = WeatherNetworkManager()
	var weatherResult: WeatherResult?

	// MARK: - Private Methods

	private func setUpNavigationBar() {
		navigationItem.title = "Weather"

		navigationItem.leftBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .edit,
			target: self,
			action: #selector(edit))

		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .add,
			target: self,
			action: #selector(addItem))
	}

	private func setUpWeatherNetworkManager() { }

	@objc private func edit() { }

	@objc private func addItem() { }
}
