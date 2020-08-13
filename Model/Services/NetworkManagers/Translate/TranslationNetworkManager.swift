//
//  TranslationNetworkManager.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 16/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

/// Class for the translation network request
class TranslationNetworkManager: NetworkManager {
	// MARK: - Init 
	init(session: URLSession, urlGenerator: URLGeneratorForTranslateProtocol = URLGeneratorForTranslate()) { 
		self.session = session 
		self.urlGenerator = urlGenerator
	}
	
	// MARK: - Public Methods
	/// Method used for the translation network call
	/// - Parameters:
	///   - source: Languages Enum
	///   - target: Languages Enum
	///   - textToTranslate: String passed in from the UITextView
	///   - completion: returns Result with TranslationResult and NetworkManagerError
	func fetchTranslationData(
		source: Languages, 
		target: Languages,
		textToTranslate: String, 
		completion: @escaping(Result<TranslationResult, NetworkManagerError>) -> Void) { 
		
		/// creating the URL for the request
		guard let url = urlGenerator.createTranslateURL(
			target: target, source: source,
			textToTranslate: textToTranslate) else { 
			completion(.failure(.failedToCreateURL(message: #function)))
			return 
		}
		/// adding parameters to the URL such as text, source and target languages
		let parameters: [String: Any] = [
			"key": "AIzaSyC-qFZOLKSpUQSmQS41iKGz8vJ7NXQKAFA", 
			"q": textToTranslate, 
			"source": source.rawValue, 
			"target": target.rawValue
		]
		/// defining request to give it a specific POST Type
		var request = URLRequest(url: url)
		request.httpMethod = HTTPMethod.post.rawValue
		request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
		guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
		request.httpBody  = httpBody
		request.timeoutInterval = 20
		
		/// making network call thorugh main NetworkManager file
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
