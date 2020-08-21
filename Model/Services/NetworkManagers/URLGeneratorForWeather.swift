//
//  URLGeneratorForWeather.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 21/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

// MARK: - URL Generator for Weather Protocol
protocol URLGeneratorForWeatherProtocol {
	func createWeatherURLForMainCity(name: String) -> URL?
}

/// Class to make the weather URL
final class URLGeneratorForWeather: URLComponentManager, URLGeneratorForWeatherProtocol {
	
	/// Function returning currency URL
	/// - Parameter name: name of the city passed in for request
	/// - Returns: fully formed URL for weather request
	func createWeatherURLForMainCity(name: String) -> URL? {
		let weatherURL = createURL(
			scheme: "http",
			host: "api.openweathermap.org",
			path: "/data/2.5/weather",
			queryItems: [
				URLQueryItem(
					name: "q",
					value: name),
				URLQueryItem(
					name: "APPID",
					value: "43e33607fe2ad4493bd13aeabd87e12f")
		])
		return weatherURL
	}
}

/// Stub used in tests
final class URLGeneratorForWeatherStub: URLComponentManagerStub, URLGeneratorForWeatherProtocol {
	func createWeatherURLForMainCity(name: String) -> URL? {
		_  = createURL(scheme: "", host: "", path: "", queryItems: [])
		return nil
	}
}
