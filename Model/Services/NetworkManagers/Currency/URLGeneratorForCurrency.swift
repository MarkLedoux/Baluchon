//
//  URLComponentsForCurrency.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 19/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

// MARK: - URL Generator For Currency Protocol
protocol URLGeneratorForCurrencyProtocol {
	func createCurrencyURL(baseNames: [String]) -> URL?
}

/// Class to make the currency URL
final class URLGeneratorForCurrency: URLComponentManager, URLGeneratorForCurrencyProtocol {
	
	/// Function returning currency URL
	/// - Parameter baseNames: Array of names that we'll take the weather of
	/// - Returns: Fully formed URL
	func createCurrencyURL(baseNames: [String]) -> URL? {
		/// transforming Array of names to String to append as query 
		let symbolsValue = baseNames.reduce("") { 
			$0.isEmpty ? "\($1)" : "\($0),\($1)"
		}
		
		let currencyURL = createURL(
			scheme: "http",
			host: "data.fixer.io",
			path: "/api/latest",
			queryItems: [
				URLQueryItem(
					name: "access_key",
					value: "ec4830ae63993cf83fa637d7c488b1bf"),
				URLQueryItem(
					name: "symbols",
					value: symbolsValue)
		])
		return currencyURL
	}
}

/// Stub used in tests
final class URLGeneratorForCurrencyStub: URLComponentManagerStub, URLGeneratorForCurrencyProtocol {
	func createCurrencyURL(baseNames: [String]) -> URL? {
		_  = createURL(scheme: "", host: "", path: "", queryItems: [])
		return nil
	}
}
