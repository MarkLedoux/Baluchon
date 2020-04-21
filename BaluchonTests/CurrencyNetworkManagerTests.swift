//
//  CurrencyNetworkManagerTests.swift
//  CurrencyNetworkManagerTests
//
//  Created by Mark LEDOUX on 04/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import XCTest
@testable import Baluchon

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

    func testURLComponentManagerShouldReturnProperURLUsingURLGeneratorForTranslate() {
        let generator = 
    }

    func testGetCurrencyDataShouldGetFailedCompletionIfError() {
        // Given
        let currencyNetworkManager = CurrencyNetworkManager(
            configuration: URLSessionFake(
                data: nil,
                response: nil,
                error: NetworkManagerError.invalidData))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        currencyNetworkManager.loadCurrency { (result) in
            // Then
            XCTAssertNil(result)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
}
