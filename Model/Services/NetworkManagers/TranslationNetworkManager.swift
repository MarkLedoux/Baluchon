//
//  TranslationNetworkManager.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 16/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
	case get = "GET", post = "POST"
}

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
		
		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = HTTPMethod.post.rawValue
		
	
		
		
		
		fetch(with: url, completion: completion)
	}
	
	// MARK: - Private Properties
	private var urlGenerator: URLGeneratorForTranslateProtocol
	private var task: URLSessionDataTask? 
	internal var session: URLSession
}
