//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 06/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

extension WeatherViewController: WeatherResultContainerDelegate {
	/// reloading the UITableView
	func didUpdateImageData() {
		DispatchQueue.main.async {
			self.weatherTableView.reloadData()
		}
	}
}

// swiftlint:disable weak_delegate
final class WeatherViewController: BaseViewController {
	@IBOutlet var weatherTableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setUpNavigationBar()
		setUpWeatherNetworkManager()
		weatherTableView.dataSource = weatherTableViewDataSource
		weatherTableView.delegate = weatherTableViewDelegate
	}
	
	/// Network call to fetch the weather image data
	/// - Parameter weatherResultDic: returning an the Array of cities to which we add the UIImage
	private func fetchImageData(_ weatherResultDic: ([WeatherResultContainer])) {
		for weatherResult in weatherResultDic { 
			guard let imageIdentifier = weatherResult.weatherResult.weather?.first?.icon else { continue }
			self.weatherNetWorkManager.getWeatherImage(imageIdentifier: imageIdentifier) { (data) in
				if let data = data { 
					weatherResult.imageData = data
				}
			}
		}
	}
	
	/// Network call to fetch the weather data
	private func fetchWeatherData() {
		showLoadingIndicator()
		weatherNetWorkManager.loadMultipleWeatherData(
		cityNames: ["New York", "London", "Tassin-La-Demi-Lune", "Moscow", "Tokyo"]) { [weak self] result in
			guard let self = self else { return }
			DispatchQueue.main.async {
				switch result { 
				case .success(let weatherResultDic): 
					
					self.hideLoadingIndicator()
					self.handle(weatherResult: weatherResultDic)
				case .failure: 
					self.onFetchWeatherDataFailure()
				}
			}
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		fetchWeatherData()
	}
	
	/// Mapping reasult of Network Call  before reloading the UITableView
	/// - Parameter weatherResult: dictionary [String: WeatherResult] for the city names passed in
	private func handle(weatherResult: [String: WeatherResult]) {
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
	}

	private func setUpWeatherNetworkManager() {
		let session = URLSession(configuration: .default)
		weatherNetWorkManager = WeatherNetworkManager(session: session)
	}

	@objc private func onFetchWeatherDataFailure() {
		presentAlertOnFetchDataFailure(
			title: "Failed to fetch data", 
			defaultButtonTitle: "Retry", 
			cancelButtonTitle: "Cancel", 
			onDefaultButtonTapAction: onTryAgainAlertButtonTapAction(alertAction:),
			on: self)
	}
	
	/// Giving the option to the user to try to fetch the data again
	private func onTryAgainAlertButtonTapAction(alertAction: UIAlertAction) {
		fetchWeatherData()
		retryButtonWasPressed()
	}
	
	private func retryButtonWasPressed() { 
		dismiss(animated: true, completion: nil)
	}
}
