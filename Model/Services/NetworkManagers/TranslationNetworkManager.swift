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
		source: Languages, 
		target: Languages,
		textToTranslate: String, 
		completion: @escaping(Result<TranslationResult, NetworkManagerError>) -> Void) { 
		guard let url = urlGenerator.createTranslateURL(
			target: target, source: source,
			textToTranslate: textToTranslate) else { 
			completion(.failure(.failedToCreateURL(message: #function)))
			return 
		}
		let parameters: [String: Any] = [
			"key": "AIzaSyC-qFZOLKSpUQSmQS41iKGz8vJ7NXQKAFA", 
			"q": textToTranslate, 
			"source": source.rawValue, 
			"target": target.rawValue
		]
		var request = URLRequest(url: url)
		request.httpMethod = HTTPMethod.post.rawValue
		request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
		guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
		request.httpBody  = httpBody
		request.timeoutInterval = 20
		
		fetch(with: request) { (result: Result<TranslationResult, NetworkManagerError>) in
			switch result { 
			case .failure(let error): 
				completion(.failure(error))
			case .success(let result): 
				completion(.success(result))
			}
		}
	}
	
	// MARK: - Private Properties
	private var urlGenerator: URLGeneratorForTranslateProtocol
	private var task: URLSessionDataTask? 
	internal var session: URLSession
}
