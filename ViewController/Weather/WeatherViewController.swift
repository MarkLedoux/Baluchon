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
	
	private func fetchWeatherData() {
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
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		fetchWeatherData()
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
	private let alertManager = AlertManager()

	// MARK: - Private Methods
	private func setUpNavigationBar() {
		navigationItem.title = "Weather"
	}

	private func setUpWeatherNetworkManager() {
		let session = URLSession(configuration: .default)
		weatherNetWorkManager = WeatherNetworkManager(session: session)
	}

	private func onFetchWeatherDataFailure() {
		alertManager.presentTwoButtonsAlert(
			title: "Failure to fetch data", 
			message: "", 
			defaultButtonTitle: "", 
			cancelButtonTitle: "", 
			onDefaultButtonTapAction: onTryAgainAlertButtonTapAction(alertAction:),
			on: self)
		print("Failed to fetch currency data")
	}
	
	private func onTryAgainAlertButtonTapAction(alertAction: UIAlertAction) {
		fetchWeatherData()
		retryButtonWasPressed()
	}
	
	private func retryButtonWasPressed() { 
		dismiss(animated: true, completion: nil)
	}
}
