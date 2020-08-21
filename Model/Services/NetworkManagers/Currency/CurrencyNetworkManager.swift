//
//  CurrencyNetworkManager.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 13/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

/// Class for the currency network request
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
		guard let url = urlGenerator.createCurrencyURL(baseNames: ["EUR", "USD", "CAD", "JPY"]) else {
			completion(.failure(.failedToCreateURL(message: #function)))
			return
		}
		/// making network call thorugh main NetworkManager file
		fetch(with: URLRequest(url: url)) { (result: Result<CurrencyResult, NetworkManagerError>) in
			switch result { 
			case .failure(let error): 
				completion(.failure(error))
			case .success(let success): 
				completion(.success(success))
			}
		}
	}
	
	// MARK: - Private Properties
	private var urlGenerator: URLGeneratorForCurrencyProtocol
	private var task: URLSessionDataTask?
	internal var session: URLSession

}
