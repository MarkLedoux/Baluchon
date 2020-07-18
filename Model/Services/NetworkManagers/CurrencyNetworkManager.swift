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
	private func loadCurrency(completion: @escaping(Result<CurrencyResult, NetworkManagerError>) -> Void) {
		guard let url = urlGenerator.createCurrencyURL() else {
			completion(.failure(.failedToCreateURL(message: #function)))
			return
		}
		fetch(with: URLRequest(url: url)) { (result: Result<CurrencyResult, NetworkManagerError>) in
			switch result { 
			case .failure(let error): 
				completion(.failure(error))
			case .success(let success): 
				completion(.success(success))
			}
		}
	}
	
	func loadMultipleCurrencies(
		currencyBaseNames: [String], 
		completion: @escaping(Result<[String: CurrencyResult], NetworkManagerError>) -> Void) { 
		
		var currencyDic: [String: CurrencyResult] = [:]
		
		for currencyBaseName in currencyBaseNames { 
			loadCurrency { result in
				switch result { 
				case .failure(let error): 
					completion(.failure(error))
				case .success(let result):
					currencyDic[currencyBaseName] = result
					if currencyDic.count >= currencyBaseNames.count { 
						completion(.success(currencyDic))
					}
				}
			}
		}
	}

	// MARK: - Private Properties
	private var urlGenerator: URLGeneratorForCurrencyProtocol
	private var task: URLSessionDataTask?
	internal var session: URLSession

}
