//
//  URLGeneratorForWeather.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 21/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

protocol URLGeneratorForWeatherProtocol {
	func createWeatherURLForMainCity(name: String) -> URL? 
	func createWeatherImageURL() -> URL?
}

final class URLGeneratorForWeather: URLComponentManager, URLGeneratorForWeatherProtocol {

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
	
	func createWeatherImageURL() -> URL? { 
		let weatherImageURL = createURL(
			scheme: "http",
			host: "api.openweathermap.org",
			path: "/img/w/",
			queryItems: [])
		return weatherImageURL
	}
}

final class URLGeneratorForWeatherStub: URLComponentManagerStub, URLGeneratorForWeatherProtocol {
	func createWeatherURLForMainCity(name: String) -> URL? {
		_  = createURL(scheme: "", host: "", path: "", queryItems: [])
		return nil
	}
	func createWeatherImageURL() -> URL? { 
		_ = createURL(scheme: "", host: "", path: "", queryItems: [])
		return nil
	}
}
