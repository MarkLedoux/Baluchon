//
//  FakeWeatherResponseData.swift
//  BaluchonTests
//
//  Created by Mark LEDOUX on 23/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

// swiftlint:disable force_try
@testable import Baluchon
class FakeWeatherResponseData: WeatherNetworkManager {
	// MARK: - Data
	static var weatherCorrectData: Data? {
		let bundle = Bundle(for: FakeWeatherResponseData.self)
		let url = bundle.url(forResource: "Weather", withExtension: "json")!
		return try! Data(contentsOf: url)
	}

	static let weatherIncorrectData = "erreur".data(using: .utf8)!
//	static let imageData = "icon".data(using: .utf8)!

	// MARK: - Response
	static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!,
																					statusCode: 200,
																					httpVersion: nil,
																					headerFields: nil)!

	static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!,
																					statusCode: 500,
																					httpVersion: nil,
																					headerFields: nil)!
	static var weatherImageCorrectData: Data? {
		let bundle = Bundle(for: FakeWeatherResponseData.self)
		let url = bundle.url(forResource: "response", withExtension: "png")!
		return try! Data(contentsOf: url)
	}
	
	static let weatherImageIncorrectData = "erreur".data(using: .utf8)

	// MARK: - Error
	class WeatherNetworkManagerError: Error {}
	static let error = WeatherNetworkManagerError()
}
