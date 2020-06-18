//
//  FakeResponseCurrencyData.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 16/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation
@testable import Baluchon

// swiftlint:disable force_try

class FakeCurrencyResponseData: CurrencyNetworkManager {
	// MARK: - Data
	static var currencyCorrectData: Data? {
		let bundle = Bundle(for: FakeCurrencyResponseData.self)
		let url = bundle.url(forResource: "Currency", withExtension: "json")!
		return try! Data(contentsOf: url)
	}

	static let currencyIncorrectData = "erreur".data(using: .utf8)!

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
	class CurrencyNetworkManagerError: Error {}
	static let error = CurrencyNetworkManagerError()
}
