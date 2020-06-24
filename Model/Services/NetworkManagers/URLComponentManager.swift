//
//  NetworkManager.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 14/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

protocol URLComponentsManagerProtocol {
	func createURL(scheme: String, host: String, path: String, queryItems: [URLQueryItem]? ) -> URL?
}

class URLComponentManager: URLComponentsManagerProtocol {
	private var components = URLComponents()
	
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

class URLComponentManagerStub: URLComponentsManagerProtocol {
	func createURL(scheme: String, host: String, path: String, queryItems: [URLQueryItem]? ) -> URL? {
		return nil
	}
}
