//
//  URLComponentsForCurrency.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 19/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

protocol URLGeneratorForCurrencyProtocol {
	func createCurrencyURL() -> URL?
}

final class URLGeneratorForCurrency: URLComponentManager, URLGeneratorForCurrencyProtocol {

	func createCurrencyURL() -> URL? {
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
					value: "EUR,USD,GBP,AUD,JPY")
		])
		return currencyURL
	}
}

final class URLGeneratorForCurrencyStub: URLGeneratorForCurrencyProtocol {
	func createCurrencyURL() -> URL? {
		return nil
	}
}
