//
//  WeatherNetworkManager.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 14/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

class WeatherNetworkManager: NetworkManager {
	let pictureUrl = URL(string: "http://openweathermap.org/img/w/01n.png")!

	// MARK: - Init
	init(session: URLSession, urlGenerator: URLGeneratorForWeatherProtocol = URLGeneratorForWeather()) {
		self.session = session
		self.urlGenerator = urlGenerator
	}
	
	// MARK: - Public Methods
	/// fetching currency data and decoding it
	/// - Parameter completion: Result with CurrencyResult and NetworkManagerError
	func loadWeatherData(completion: @escaping(Result<WeatherResult, NetworkManagerError>) -> Void) {
		guard let url = urlGenerator.createWeatherURL() else {
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
	
	// MARK: - Private Properties
	private var urlGenerator: URLGeneratorForWeatherProtocol
	private var task: URLSessionDataTask?
	internal var session: URLSession
	
	// MARK: - Private Methods
	private func getWeatherImage(completionHandler: @escaping ((Data?) -> Void)) {
		let session = URLSession(configuration: .default)
		let task = session.dataTask(with: pictureUrl) { (data, response, error) in
			if let data = data, error == nil {
				if let response = response as? HTTPURLResponse, response.statusCode == 200 {
					completionHandler(data) // On passe les données via le completionHandler
				}
			}
		}
		task.resume()
	}
}
