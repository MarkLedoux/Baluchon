//
//  TranslationNetworkManagerTests.swift
//  BaluchonTests
//
//  Created by Mark LEDOUX on 23/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import XCTest
@testable import Baluchon

// swiftlint:disable line_length
class TranslationNetworkManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testURLComponentManagerShouldReturnProperURLUsingURLGeneratorForTranslate() {
        // Given
        let generator = URLGeneratorForTranslate()

        // When
        let translateURL = generator.createTranslateURL()

        // Then
        XCTAssertEqual(translateURL, URL(string: "https://translation.googleapis.com/language/translate/v2?key=AIzaSyC-qFZOLKSpUQSmQS41iKGz8vJ7NXQKAFA&q=textToTranslate&source=en&target=fr"))
    }

    func testGetTranslationDataShoulFailCompletionIfError() {
        // Given
        let translationNetworkManager = TranslationNetworkManager(
            session: URLSessionFake(
                data: nil,
                response: nil,
                error: NetworkManagerError.failedToFetchRessource(underlineError: nil)))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translationNetworkManager.makeRequest(textToTranslate: "") { _ in
            // Then
            XCTAssertNotNil(NetworkManagerError.failedToFetchRessource)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationDataShouldFailCompletionIfNoData() {
        // Given
        let translationNetworkManager = TranslationNetworkManager(
            session: URLSessionFake(
                data: nil,
                response: nil,
                error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translationNetworkManager.makeRequest(textToTranslate: "") { _ in
            // Then
            XCTAssertNotNil(FakeTranslateResponseData.error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationDataShoulFailCompletionIfIncorrectResponse() {
        // Given
        let translationNetworkManager = TranslationNetworkManager(
            session: URLSessionFake(
                data: FakeTranslateResponseData.translationCorrectData,
                response: FakeTranslateResponseData.responseKO,
                error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translationNetworkManager.makeRequest(textToTranslate: "") { _ in
            // Then
            XCTAssertNotNil(NetworkManagerError.responseUnsuccessful)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationDataShoulFailCompletionIfIncorrectData() {
        // Given
        let translationNetworkManager = TranslationNetworkManager(
            session: URLSessionFake(
                data: FakeTranslateResponseData.translationIncorrectData,
                response: FakeTranslateResponseData.responseOK,
                error: nil))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        translationNetworkManager.makeRequest(textToTranslate: "") { _ in
            // Then
            XCTAssertNotNil(NetworkManagerError.failedToFetchRessource)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
