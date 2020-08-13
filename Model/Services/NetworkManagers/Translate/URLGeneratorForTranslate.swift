//
//  URLGeneratorForTranslate.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 21/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

// MARK: - URL Generator for Translation Protocol
protocol URLGeneratorForTranslateProtocol {  
	func createTranslateURL(target: Languages, source: Languages, textToTranslate: String) -> URL?
}

/// Class to make the translation URL
final class URLGeneratorForTranslate: URLComponentManager, URLGeneratorForTranslateProtocol {
	
	/// Function returning currency URL
	/// - Parameters:
	///   - target: Languages Enum
	///   - source: Languages Enum
	///   - textToTranslate: string provided by UITextView
	/// - Returns: Fully formed URL for POST Request
	func createTranslateURL(target: Languages, source: Languages, textToTranslate: String) -> URL? {
		let translateURL = createURL(
			scheme: "https",
			host: "translation.googleapis.com",
			path: "/language/translate/v2",
			queryItems: [
				URLQueryItem(
					name: "key",
					value: "AIzaSyC-qFZOLKSpUQSmQS41iKGz8vJ7NXQKAFA"),
				URLQueryItem(
					name: "q",
					value: textToTranslate),
				URLQueryItem(
					name: "source",
					value: source.rawValue),
				URLQueryItem(
					name: "target",
					value: target.rawValue)
		])
		return translateURL
	}
}

/// Stub used in tests
final class URLGeneratorForTranslateStub: URLComponentManagerStub, URLGeneratorForTranslateProtocol {
	func createTranslateURL(
		target: Languages, 
		source: Languages,
		textToTranslate: String) -> URL? {
		_  = createURL(scheme: "", host: "", path: "", queryItems: [])
		return nil
	}
}
