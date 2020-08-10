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
		let translateURL = generator.createTranslateURL(target: .english, source: .french, textToTranslate: "")

		// Then
		XCTAssertEqual(translateURL, URL(string: "https://translation.googleapis.com/language/translate/v2?key=AIzaSyC-qFZOLKSpUQSmQS41iKGz8vJ7NXQKAFA&q=&source=fr&target=en"))
	}
	
	func testURLComponentsManagerShouldFailWhenWrongURLIsPassedIn() { 
		// Given 
		let generator = URLGeneratorForTranslateStub()
		let translationNetworkManager = TranslationNetworkManager(
			session: URLSessionFake(
				data: nil, 
				response: nil, 
				error: nil), 
			urlGenerator: generator)
		
		// When
		let expectation = XCTestExpectation(description: "Wait for queue change")
		
		translationNetworkManager.fetchTranslationData(source: .french, target: .english, textToTranslate: "") { result in 
			if 
				case .failure(let error) = result, 
				case NetworkManagerError.failedToCreateURL(
					message: "fetchTranslationData(source:target:textToTranslate:completion:)") = error { 
				expectation.fulfill()
			}
		}
		wait(for: [expectation], timeout: 0.01)
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
		translationNetworkManager.fetchTranslationData(source: .french, target: .english, textToTranslate: "") { result in
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

	func testGetTranslationDataShouldFailCompletionIfNoData() {
		// Given
		let translationNetworkManager = TranslationNetworkManager(
			session: URLSessionFake(
				data: nil,
				response: nil,
				error: nil))

		// When
		let expectation = XCTestExpectation(description: "Wait for queue change")
		translationNetworkManager.fetchTranslationData(source: .french, target: .english, textToTranslate: "") { _ in
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
		translationNetworkManager.fetchTranslationData(source: .french, target: .english, textToTranslate: "") { result in
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

	func testGetTranslationDataShoulFailCompletionIfIncorrectData() {
		// Given
		let translationNetworkManager = TranslationNetworkManager(
			session: URLSessionFake(
				data: FakeTranslateResponseData.translationIncorrectData,
				response: FakeTranslateResponseData.responseOK,
				error: nil))

		// When
		let expectation = XCTestExpectation(description: "Wait for queue change")
		translationNetworkManager.fetchTranslationData(source: .french, target: .english, textToTranslate: "") { _ in
			// Then
			XCTAssertNotNil(NetworkManagerError.noDataAfterFetchingResource)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 0.01)
	}

	func testGetTranslationDataShouldSucceedCompletionIfCorrectDataAndCorrectResponseNoError() {
		// Given
		let translationNetworkManager = TranslationNetworkManager(
			session: URLSessionFake(
				data: FakeTranslateResponseData.translationCorrectData,
				response: FakeTranslateResponseData.responseOK,
				error: nil))

		// When
		let expectation = XCTestExpectation(description: "Wait for queue change")
		translationNetworkManager.fetchTranslationData(source: .french, target: .french, textToTranslate: "", completion: { (result) in
			// Then
			XCTAssertNotNil(result)
			let translationResult =
				"The Great Pyramid of Giza (also known as the Pyramid of Khufu or the Pyramid of Cheops) is the oldest and largest of the three pyramids in the Giza pyramid complex."
			if case let .success(translatedTextResult) = result {
				XCTAssertEqual(translatedTextResult.data.translations.first!.translatedText, translationResult)
			}
			expectation.fulfill()
		})
		wait(for: [expectation], timeout: 0.01)
	}
}
