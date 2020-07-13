//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 06/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

extension WeatherViewController: WeatherResultContainerDelegate {
	func didUpdateImageData() {
		DispatchQueue.main.async {
			self.weatherTableView.reloadData()
		}
	}
}

// swiftlint:disable weak_delegate

final class WeatherViewController: UIViewController {
	@IBOutlet var weatherTableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setUpNavigationBar()
		setUpWeatherNetworkManager()
		weatherTableView.dataSource = weatherTableViewDataSource
		weatherTableView.delegate = weatherTableViewDelegate
	}
	
	private func fetchImageData(_ weatherResultDic: ([WeatherResultContainer])) {
		for weatherResult in weatherResultDic { 
			guard let imageIdentifier = weatherResult.weatherResult.weather?.first?.icon else { continue }
			self.weatherNetWorkManager.getWeatherImage(imageIdentifier: imageIdentifier) { (data) in
				if let data = data { 
					print(data)
					
					weatherResult.imageData = data
					
				}
			}
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		weatherNetWorkManager.loadMultipleWeatherData(
		cityNames: ["New York", "London", "Tassin-La-Demi-Lune", "Moscow", "Tokyo"]) { [weak self] result in
			guard let self = self else { return }
			switch result { 
			case .success(let weatherResultDic): 
				DispatchQueue.main.async {
					self.handle(weatherResult: weatherResultDic)
				}
			case .failure: 
				print("Failed to fetch weather data ")
			}
		}
	}
	
	func handle(weatherResult: [String: WeatherResult]) {
		weatherTableViewDataSource.weatherResults = weatherResult
			.map { $0.value }
			.map {
				let container = WeatherResultContainer(weatherResult: $0)
				container.delegate = self
				return container
		} 
		weatherTableView.reloadData()
		fetchImageData(weatherTableViewDataSource.weatherResults)
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
