//
//  CurrencyNetworkManagerTests.swift
//  CurrencyNetworkManagerTests
//
//  Created by Mark LEDOUX on 04/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import XCTest
@testable import Baluchon

// swiftlint:disable line_length
class CurrencyNetworkManagerTests: XCTestCase {
	
	func testURLComponentManagerShouldReturnProperURLWhenUsingURLGeneratorforCurrency() {
		// Given
		let generator = URLGeneratorForCurrency()
		
		// When
		let currencyURL = generator.createCurrencyURL(baseNames: ["EUR", "USD", "GBP", "AUD", "JPY"])
		
		// Then
		XCTAssertEqual(
			currencyURL,
			URL(string: "http://data.fixer.io/api/latest?access_key=ec4830ae63993cf83fa637d7c488b1bf&symbols=EUR,USD,GBP,AUD,JPY"))
	}
	
	func testURLComponentsManagerShouldFailWhenWrongURLIsPassedIn() { 
		// Given 
		let generator = URLGeneratorForCurrencyStub()
		let currencyNetworkManager = CurrencyNetworkManager(session: URLSessionFake(data: nil, response: nil, error: nil), urlGenerator: generator)
		
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change")
		
		currencyNetworkManager.loadCurrency { result in
			if
				case .failure(let error) = result,
				case NetworkManagerError.failedToCreateURL(message: "loadCurrency(completion:)") = error {
				expectation.fulfill()
			}
		}
		wait(for: [expectation], timeout: 0.01)
	}
	
	func testGetCurrencyDataShoulFailCompletionIfError() {
		// Given
		let currencyNetworkManager = CurrencyNetworkManager(
			session: URLSessionFake(
				data: nil,
				response: nil,
				error: NetworkManagerError.failedToFetchRessource(underlineError: nil)))
		
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change")
		
		currencyNetworkManager.loadCurrency { result in
			if
				case .failure(let error) = result,
				case NetworkManagerError.failedToFetchRessource(underlineError: _) = error
			{
				expectation.fulfill()
			}
		}
		wait(for: [expectation], timeout: 0.01)
	}
	
	func testGetCurrencyDataShoulFailCompletionIfNoData() {
		// Given
		let currencyNetworkManager = CurrencyNetworkManager(
			session: URLSessionFake(
				data: nil,
				response: nil,
				error: nil))
		
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change")
		currencyNetworkManager.loadCurrency { (_) in
			XCTAssertNotNil(FakeCurrencyResponseData.error)
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 0.01)
	}
	
	func testGetCurrencyDataShoulFailCompletionIfIncorrectResponse() {
		// Given
		let currencyNetworkManager = CurrencyNetworkManager(
			session: URLSessionFake(
				data: FakeCurrencyResponseData.currencyCorrectData,
				response: FakeCurrencyResponseData.responseKO,
				error: nil))
		
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change")
		
		currencyNetworkManager.loadCurrency { result in
			if
				case .failure(let error) = result,
				case NetworkManagerError.responseUnsuccessful = error
			{
				expectation.fulfill()
			}
		}
		wait(for: [expectation], timeout: 0.01)
	}
	
	func testGetCurrencyDataShoulFailCompletionIfIncorrectData() {
		// Given
		let currencyNetworkManager = CurrencyNetworkManager(
			session: URLSessionFake(
				data: FakeCurrencyResponseData.currencyIncorrectData,
				response: FakeCurrencyResponseData.responseOK,
				error: nil))
		
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change")
		
		currencyNetworkManager.loadCurrency { (_) in
			XCTAssertNotNil(NetworkManagerError.noDataAfterFetchingResource)
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 0.01)
	}
	
	func testGetCurrencyDataShouldSucceedCompletionIfCorrectDataAndCorrectResponseNoError() {
		// Given
		let currencyNetworkManager = CurrencyNetworkManager(
			session: URLSessionFake(
				data: FakeCurrencyResponseData.currencyCorrectData,
				response: FakeCurrencyResponseData.responseOK,
				error: nil))
		
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change")
		
		currencyNetworkManager.loadCurrency { result in
			
			XCTAssertNotNil(result)
			let rateResult = [
				"USD": 1.088234,
				"GBP": 0.871278,
				"CAD": 1.533863,
				"AUD": 1.725439,
				"JPY": 117.225674
			]
			if case let .success(currencyRatesResult) = result {
				XCTAssertEqual(currencyRatesResult.rates, rateResult)
			}
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}
}
