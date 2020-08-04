//
//  URLGeneratorForTranslate.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 21/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

protocol URLGeneratorForTranslateProtocol {  
	func createTranslateURL(target: Languages, source: Languages, textToTranslate: String) -> URL?
}

final class URLGeneratorForTranslate: URLComponentManager, URLGeneratorForTranslateProtocol {

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

//TODO : - find a way to exchange the source and the target

final class URLGeneratorForTranslateStub: URLComponentManagerStub, URLGeneratorForTranslateProtocol {
	func createTranslateURL(
		target: Languages, 
		source: Languages,
		textToTranslate: String) -> URL? {
		_  = createURL(scheme: "", host: "", path: "", queryItems: [])
		return nil
	}
}
