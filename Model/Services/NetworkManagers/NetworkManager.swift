//
//  NetworkManager.swift
//  BaluchonTests
//
//  Created by Mark LEDOUX on 16/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

// MARK: - Services Main Protocol
protocol NetworkManager: class {
	var session: URLSession { get }
	func fetch<T: Codable>(
		with url: URLRequest,
		completion: @escaping(Result<T, NetworkManagerError>) -> Void)
}

// MARK: - Extension for services
extension NetworkManager {
	/// Main function used in the whole project for network calls
	/// - Parameters:
	///   - url: URLRequest to pass in the URL after it is built
	///   - completion: Generic Type T for different types and NetworkManagerError
	func fetch<T: Codable>(
		with url: URLRequest,
		completion: @escaping (Result<T, NetworkManagerError>) -> Void) {
		
		//  setting up the task
		let task = session.dataTask(with: url) { data, response, error in
			if let error = error {
				completion(.failure(.failedToFetchRessource(underlineError: error)))
				return
			}

			guard let data = data else {
				completion(.failure(.noDataAfterFetchingResource))
				return
			}

			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				completion(.failure(.responseUnsuccessful))
				return
			}

			guard let result = try? JSONDecoder().decode(T.self, from: data) else {
				completion(.failure(.jsonParsingFailure))
				return
			}
			completion(.success(result))
		}
		task.resume()
	}
}
