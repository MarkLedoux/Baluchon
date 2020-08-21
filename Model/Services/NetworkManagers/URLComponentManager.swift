//
//  NetworkManager.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 14/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

// MARK: - URL Components Manager Protocol
protocol URLComponentsManagerProtocol {
	func createURL(scheme: String, host: String, path: String, queryItems: [URLQueryItem]? ) -> URL?
}

// MARK: Main URL components used to make the URLS
class URLComponentManager: URLComponentsManagerProtocol {
	private var components = URLComponents()
	
	/// main function called when building URLs
	/// - Parameters:
	///   - scheme: String http or https
	///   - host: address main component
	///   - path: specifications of the address
	///   - queryItems: custom query items
	/// - Returns: full URL
	func createURL(scheme: String, host: String, path: String, queryItems: [URLQueryItem]? ) -> URL? {
		var url: URL? {
			components.scheme = scheme
			components.host = host
			components.path = path
			components.queryItems = queryItems
			return components.url
		}
		return url
	}
}

/// Stub used in the tests 
class URLComponentManagerStub: URLComponentsManagerProtocol {
	func createURL(scheme: String, host: String, path: String, queryItems: [URLQueryItem]? ) -> URL? {
		return nil
	}
}
