//
//  URLGeneratorForWeather.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 21/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

protocol URLGeneratorForWeatherProtocol {
	func createWeatherURL() -> URL? 
}

final class URLGeneratorForWeather: URLComponentManager, URLGeneratorForWeatherProtocol {

	func createWeatherURL() -> URL? {
		let currencyURL = createURL(
			scheme: "http",
			host: "api.openweathermap.org",
			path: "/data/2.5/weather",
			queryItems: [
				URLQueryItem(
					name: "q",
					value: "London,uk"),
				URLQueryItem(
					name: "APPID",
					value: "43e33607fe2ad4493bd13aeabd87e12f")
		])
		return currencyURL
	}
}
