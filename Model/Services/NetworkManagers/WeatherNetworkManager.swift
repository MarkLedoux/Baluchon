//
//  WeatherNetworkManager.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 14/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

class WeatherNetworkManager: NetworkManager {
	let pictureUrl = "http://openweathermap.org/img/w/"

	// MARK: - Init
	init(session: URLSession, urlGenerator: URLGeneratorForWeatherProtocol = URLGeneratorForWeather()) {
		self.session = session
		self.urlGenerator = urlGenerator
	}
	
	// MARK: - Public Methods
	/// fetching currency data and decoding it
	/// - Parameter completion: Result with CurrencyResult and NetworkManagerError
	private func loadWeatherData(
		cityName: String, 
		completion: @escaping(Result<WeatherResult, NetworkManagerError>) -> Void) {
		guard let url = urlGenerator.createWeatherURLForMainCity(name: cityName) else {
			completion(.failure(.failedToCreateURL(message: #function)))
			return
		}
		fetch(with: URLRequest(url: url)) { (result: Result<WeatherResult, NetworkManagerError>) in
			switch result { 
			case .failure(let error): 
				completion(.failure(error))
			case .success(let result):
				completion(.success(result))
			}
		}
	}
	
	func loadMultipleWeatherData(
		cityNames: [String], 
		completion: @escaping(Result<[String: WeatherResult], NetworkManagerError>) -> Void) {
		
		var weatherDic: [String: WeatherResult] = [:]
		
		for cityName in cityNames {
			loadWeatherData(cityName: cityName) { result in
				switch result { 
				case .failure(let error): 
					completion(.failure(error))
				case .success(let result):
					weatherDic[cityName] = result
					if weatherDic.count >= cityNames.count { 
						completion(.success(weatherDic))
					}
				}
			}
		}
	}
	
	// MARK: - Private Properties
	private var urlGenerator: URLGeneratorForWeatherProtocol
	private var task: URLSessionDataTask?
	internal var session: URLSession
	
	// MARK: - Private Methods
	func getWeatherImage(imageIdentifier: String, completion: @escaping ((Data?) -> Void)) {
		let url = URL(string: pictureUrl + imageIdentifier + ".png")!
		let task = session.dataTask(with: url) { (data, response, error) in
			guard let data = data, error == nil else { return }
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
			completion(data)
		}
		task.resume()
	}
}
