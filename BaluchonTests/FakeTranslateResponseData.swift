//
//  FakeTranslateResponseData.swift
//  BaluchonTests
//
//  Created by Mark LEDOUX on 23/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation
@testable import Baluchon

// swiftlint:disable force_try
class FakeTranslateResponseData: TranslationNetworkManager {
	// MARK: - Data
	static var translationCorrectData: Data? {
		let bundle = Bundle(for: FakeTranslateResponseData.self)
		let url = bundle.url(forResource: "Translation", withExtension: "json")!
		return try! Data(contentsOf: url)
	}

	static let translationIncorrectData = "erreur".data(using: .utf8)!

	// MARK: - Response
	static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!,
																					statusCode: 200,
																					httpVersion: nil,
																					headerFields: nil)!

	static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!,
																					statusCode: 500,
																					httpVersion: nil,
																					headerFields: nil)!

	// MARK: - Error
	class TranslateNetworkManagerError: Error {}
	static let error = TranslateNetworkManagerError()
}
