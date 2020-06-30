//
//  URLGeneratorForTranslate.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 21/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

protocol URLGeneratorForTranslateProtocol {  
	func createTranslateURL(textToTranslate: String) -> URL?
}

final class URLGeneratorForTranslate: URLComponentManager, URLGeneratorForTranslateProtocol {

	func createTranslateURL(textToTranslate: String) -> URL? {
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
					value: "en"),
				URLQueryItem(
					name: "target",
					value: "fr")
		])
		return translateURL
	}
}

final class URLGeneratorForTranslateStub: URLComponentManagerStub, URLGeneratorForTranslateProtocol {
	func createTranslateURL(textToTranslate: String) -> URL? {
		_  = createURL(scheme: "", host: "", path: "", queryItems: [])
		return nil
	}
}
