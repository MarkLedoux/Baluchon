//
//  WeatherNetworkManagerTests.swift
//  BaluchonTests
//
//  Created by Mark LEDOUX on 23/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import XCTest
@testable import Baluchon

// swiftlint:disable line_length
class WeatherNetworkManagerTests: XCTestCase {
	
	override func setUpWithError() throws {
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDownWithError() throws {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}
	
	func testURLComponentManagerShouldReturnProperURLUsingURLGeneratorForWeather() {
		// Given
		let generator = URLGeneratorForWeather()
		
		// When
		let weatherURL = generator.createWeatherURLForMainCity(name: "London")
		
		// Then
		XCTAssertEqual(weatherURL, URL(string: "http://api.openweathermap.org/data/2.5/weather?q=London&APPID=43e33607fe2ad4493bd13aeabd87e12f"))
	}
	
	func testURLComponentsManagerShouldFailWhenWrongURLIsPassedIn() { 
		// Given 
		let generator = URLGeneratorForWeatherStub()
		let weatherNetworkManager = WeatherNetworkManager(
			session: URLSessionFake(
				data: nil, 
				response: nil, 
				error: nil), 
			urlGenerator: generator)
		
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change")
		
		weatherNetworkManager.loadMultipleWeatherData(cityNames: ["New York"]) { result in
			// Then
			if
				case .failure(let error) = result,
				case NetworkManagerError.failedToCreateURL(message: "loadWeatherData(cityName:completion:)") = error { 
				expectation.fulfill()
			}
		}
		wait(for: [expectation], timeout: 0.01)
	}
	
	func testGetWeatherDataShouldFailCompletionIfError() {
		// Given
		let weatherNetworkManager = WeatherNetworkManager(
			session: URLSessionFake(
				data: nil,
				response: nil,
				error: NetworkManagerError.failedToFetchRessource(underlineError: nil)))
		
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change")
		weatherNetworkManager.loadMultipleWeatherData(cityNames: ["New York"]) { result in
			// Then
			if
				case .failure(let error) = result,
				case NetworkManagerError.failedToFetchRessource(underlineError: _) = error
			{
				expectation.fulfill()
			}
		}
		wait(for: [expectation], timeout: 0.01)
	}
	
	func testGetWeatherDataShouldFailCompletionIfNoData() {
		// Given
		let weatherNetworkManager = WeatherNetworkManager(
			session: URLSessionFake(
				data: nil,
				response: nil,
				error: nil))
		
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change")
		weatherNetworkManager.loadMultipleWeatherData(cityNames: ["New York"]) { _ in
			// Then
			XCTAssertNotNil(FakeWeatherResponseData.error)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	
	func testGetWeatherDataShouldFailCompletionIfIncorrectResponse() {
		// Given
		let weatherNetworkManager = WeatherNetworkManager(
			session: URLSessionFake(
				data: FakeWeatherResponseData.weatherCorrectData,
				response: FakeWeatherResponseData.responseKO,
				error: nil))
		
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change")
		weatherNetworkManager.loadMultipleWeatherData(cityNames: ["New York"]) { result in
			// Then
			if
				case .failure(let error) = result,
				case NetworkManagerError.responseUnsuccessful = error
			{
				expectation.fulfill()
			}
		}
		wait(for: [expectation], timeout: 0.01)
	}
	
	func testGetWeatherDataShouldFailCompletionIfIncorrectData() {
		// Given
		let weatherNetworkManager = WeatherNetworkManager(
			session: URLSessionFake(
				data: FakeWeatherResponseData.weatherIncorrectData,
				response: FakeWeatherResponseData.responseOK,
				error: nil))
		
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change")
		weatherNetworkManager.loadMultipleWeatherData(cityNames: ["New York"]) { _ in
			// Then
			XCTAssertNotNil(NetworkManagerError.failedToFetchRessource)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	
	func testGetWeatherDataShouldSucceedCompletionIfCorrectDataAndCorrectResponseNoError() {
		// Given
		let weatherNetworkManager = WeatherNetworkManager(
			session: URLSessionFake(
				data: FakeWeatherResponseData.weatherCorrectData,
				response: FakeWeatherResponseData.responseOK,
				error: nil))
		
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change")
		weatherNetworkManager.loadMultipleWeatherData(cityNames: ["New York"]) { result in
			// Then
			XCTAssertNotNil(result)
			let tempWeatherResult = 285.83
			let nameWeatherResult = "New York"
			let mainWeatherResult = "Clouds"
			if case let .success(weatherTempResult) = result { 
				let weatherResult = weatherTempResult
					.map { $0.value }
				XCTAssertEqual(weatherResult.first?.main?.temp, tempWeatherResult)
				XCTAssertEqual(weatherResult.first?.name, nameWeatherResult)
				XCTAssertEqual(weatherResult.first?.weather?.first?.main, mainWeatherResult)
			}
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
	
	func testMyTesyt() {
		// Given
		let weatherNetworkManager = WeatherNetworkManager(
			session: URLSessionFake(
				data: FakeWeatherResponseData.weatherImageCorrectData,
				response: FakeWeatherResponseData.responseOK,
				error: nil))
		
		weatherNetworkManager.getWeatherImage(imageIdentifier: "0001") { (data) in
			XCTAssertEqual(data, FakeWeatherResponseData.weatherImageCorrectData)
		}
	}
}
