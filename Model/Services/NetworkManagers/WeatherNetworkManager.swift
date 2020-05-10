//
//  WeatherNetworkManager.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 14/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

class WeatherNetworkManager: NetworkManager {
	
	// MARK: - Public Properties
	
	/// setting up weather delegate
	weak var delegate: WeatherDelegate?
	
	// MARK: - Private Properties
	private var urlGenerator = URLGeneratorForWeather()
	
	private var task: URLSessionDataTask?
	internal var session: URLSession
	
	init(session: URLSession) {
		self.session = session
	}
	
	init(configuration: URLSessionConfiguration = .default) {
		session = URLSession(configuration: configuration)
	}
	
	/// fetching weather data and decoding it 
	func loadWeatherData(completion: @escaping(Result<WeatherResult, NetworkManagerError>) -> Void) {
		guard let url = urlGenerator.createWeatherURL() else {
			completion(.failure(.failedToCreateURL(message: #function)))
			return
		}
		fetch(with: url, completion: completion)
	}
}
