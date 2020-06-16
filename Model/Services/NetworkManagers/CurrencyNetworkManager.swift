//
//  CurrencyNetworkManager.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 13/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

class CurrencyNetworkManager: NetworkManager {
	// MARK: - Init
	init(session: URLSession, urlGenerator: URLGeneratorForCurrencyProtocol = URLGeneratorForCurrency()) {
		self.session = session
		self.urlGenerator = urlGenerator
	}

	// MARK: - Public Methods
	/// fetching currency data and decoding it
	/// - Parameter completion: Result with CurrencyResult and NetworkManagerError
	func loadCurrency(completion: @escaping(Result<CurrencyResult, NetworkManagerError>) -> Void) {
		guard let url = urlGenerator.createCurrencyURL() else {
			completion(.failure(.failedToCreateURL(message: #function)))
			return
		}
		fetch(with: URLRequest(url: url), decode: { (result) -> CurrencyResult? in
			guard let result = result as? CurrencyResult else { return nil }
			return result
		}, completion: completion)
	}

	// MARK: - Private Properties
	private var urlGenerator: URLGeneratorForCurrencyProtocol
	private var task: URLSessionDataTask?
	internal var session: URLSession

}
