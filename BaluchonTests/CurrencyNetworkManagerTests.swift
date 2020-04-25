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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testURLComponentManagerShouldReturnProperURLWhenUsingURLGeneratorforCurrency() {
        // Given
        let generator = URLGeneratorForCurrency()

        // When
        let currencyURL = generator.createCurrencyURL()

        // Then
        XCTAssertEqual(
            currencyURL,
            URL(string: "http://data.fixer.io/api/latest?access_key=ec4830ae63993cf83fa637d7c488b1bf&symbols=EUR,USD,GBP,AUD,JPY"))
    }

    func testGetCurrencyDataShoulFailCompletionIfError() {
        // Given
        let currencyNetworkManager = CurrencyNetworkManager(session: URLSessionFake(data: nil, response: nil, error: NetworkManagerError.failedToFetchRessource))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        currencyNetworkManager.loadCurrency { _ in
            // Then
            XCTAssertNotNil(NetworkManagerError.failedToFetchRessource)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetCurrencyDataShoulFailCompletionIfNoData() {
        // Given
        let currencyNetworkManager = CurrencyNetworkManager(session: URLSessionFake(data: nil, response: nil, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        currencyNetworkManager.loadCurrency { _ in
            // Then
            XCTAssertNotNil(FakeCurrencyResponseData.error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetCurrencyDataShoulFailCompletionIfIncorrectResponse() {
        // Given
        let currencyNetworkManager = CurrencyNetworkManager(session: URLSessionFake(data: FakeCurrencyResponseData.currencyCorrectData, response: FakeCurrencyResponseData.responseKO, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        currencyNetworkManager.loadCurrency { _ in
            // Then
            XCTAssertNotNil(NetworkManagerError.responseUnsuccessful)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetCurrencyDataShoulFailCompletionIfIncorrectData() {
        // Given
        let currencyNetworkManager = CurrencyNetworkManager(session: URLSessionFake(data: FakeCurrencyResponseData.currencyIncorrectData, response: FakeCurrencyResponseData.responseOK, error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        currencyNetworkManager.loadCurrency { _ in
            // Then
            XCTAssertNotNil(NetworkManagerError.failedToFetchRessource)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
