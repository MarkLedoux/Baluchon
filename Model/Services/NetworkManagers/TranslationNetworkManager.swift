//
//  TranslationNetworkManager.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 16/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

class TranslationNetworkManager: NetworkManager {
	// MARK: - Init 
	init(session: URLSession, urlGenerator: URLGeneratorForTranslateProtocol = URLGeneratorForTranslate()) { 
		self.session = session 
		self.urlGenerator = urlGenerator
	}
	
	// MARK: - Public Methods
	func fetchTranslationData(
		textToTranslate: String, 
		completion: @escaping(Result<TranslationResult, NetworkManagerError>) -> Void) { 
		guard let url = urlGenerator.createTranslateURL() else { 
			completion(.failure(.failedToCreateURL(message: #function)))
			return 
		}
		let parameters: [String: Any] = [
			"key": "AIzaSyC-qFZOLKSpUQSmQS41iKGz8vJ7NXQKAFA", 
			"q": "textToTranslate", 
			"source": "en", 
			"target": "fr"
		]
		var request = URLRequest(url: url)
		request.httpMethod = HTTPMethod.post.rawValue
		request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
		guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
		request.httpBody  = httpBody
		request.timeoutInterval = 20
		
		fetch(with: request, decode: { (result) -> TranslationResult? in
			guard let result = result as? TranslationResult else { return nil }
			return result
		}, completion: completion)
	}
	
	// MARK: - Private Properties
	private var urlGenerator: URLGeneratorForTranslateProtocol
	private var task: URLSessionDataTask? 
	internal var session: URLSession
}
