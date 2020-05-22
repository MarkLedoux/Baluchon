//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 06/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

// swiftlint:disable weak_delegate
extension WeatherViewController: WeatherDelegate {
	// TODO: - fetch not only weatherresult but also get the information of the images, scroll while loading the images and check that the URL corresponds to the basic URL 
	func didGetWeatherData(weatherResult: WeatherResult) {
		weatherTableViewDataSource.weatherResult = weatherResult
		weatherTableView.reloadData()
	}
}

final class WeatherViewController: UIViewController {
	@IBOutlet var weatherTableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setUpNavigationBar()
		setUpWeatherNetworkManager()
		weatherTableView.dataSource = weatherTableViewDataSource
		weatherTableView.delegate = weatherTableViewDelegate
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		weatherNetWorkManager.loadWeatherData { [weak self] result in
			guard let self = self else { return }
			switch result { 
			case .success(let weatherResult): 
				DispatchQueue.main.async {
					self.handle(weatherResult: weatherResult)
				}
				print("Successfully fetched weather data")
			case .failure: 
				print("Failed to fetch weather data ")
			}
		}
	}
	
	func handle(weatherResult: WeatherResult) {
		weatherTableViewDataSource.weatherResult = weatherResult
		weatherTableView.reloadData()
	}

	// MARK: - Properties
	private var weatherNetWorkManager: WeatherNetworkManager!
	
	private let weatherTableViewDataSource = WeatherTableViewDataSource()
	private let weatherTableViewDelegate = WeatherTableViewDelegate()

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

	private func setUpWeatherNetworkManager() {
		let session = URLSession(configuration: .default)
		weatherNetWorkManager = WeatherNetworkManager(session: session)
	}

	@objc private func edit() { }

	@objc private func addItem() { }
}
