//
//  NetworkManager.swift
//  BaluchonTests
//
//  Created by Mark LEDOUX on 16/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

protocol NetworkManager: class {
	var session: URLSession { get }
	func fetch<T: Codable>(
		with url: URLRequest,
		completion: @escaping(Result<T, NetworkManagerError>) -> Void)
}

// TODO: - extend NetworkManager to be able to handle post requests
extension NetworkManager {
	typealias JSONTaskCompletionHandler = (Codable?, NetworkManagerError?) -> Void
	
	private func decodingTask<T: Codable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask { 
		
		let task = session.dataTask(with: request) { data, response, error in 
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { 
				completion(nil, .failedToFetchRessource(underlineError: error))
				return 
			}
			
			guard let data = data else { 
				completion(nil, .invalidData)
				return 
			}
			
			guard let genericModel = try? JSONDecoder().decode(decodingType, from: data) else { 
				completion(nil, .jsonConversionFailure)
				return
			}
			completion(genericModel, nil)
		}
		return task
	}
	
	func fetch<T: Codable>(with request: URLRequest, decode: @escaping (Codable) -> T?, completion: @escaping (Result<T, NetworkManagerError>) -> Void) { 
		let task = decodingTask(with: request, decodingType: T.self) { (result, error) in
			DispatchQueue.main.async {
				guard let result = result else { 
					error != nil ? completion(.failure(.jsonConversionFailure)) : completion(.failure(.invalidData))
					return
				}
				
				guard let value = decode(result) else { 
					completion(.failure(.jsonParsingFailure))
					return
				}
				completion(.success(value))
			}
		}
		task.resume()
	}
	
//	func fetch<T: Codable>(
//		with url: URLRequest,
//		completion: @escaping (Result<T, NetworkManagerError>) -> Void) {
//		
//		url.httpMethod = 
//		
//		let task = session.dataTask(with: url) { data, response, error in
//			if let error = error {
//				completion(.failure(.failedToFetchRessource(underlineError: error)))
//				return
//			}
//
//			guard let data = data else {
//				completion(.failure(.noDataAfterFetchingResource))
//				return
//			}
//
//			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//				completion(.failure(.responseUnsuccessful))
//				return
//			}
//
//			guard let result = try? JSONDecoder().decode(T.self, from: data) else {
//				completion(.failure(.jsonParsingFailure))
//				return
//			}
//			completion(.success(result))
//		}
//		task.resume()
//	}
}
