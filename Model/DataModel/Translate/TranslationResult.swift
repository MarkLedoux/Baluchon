//
//  Translate.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 13/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

/// defining translation data
struct TranslationResult: Codable {
	let data: DataClass
}
// MARK: - DataClass
struct DataClass: Codable {
	let translations: [Translation]
}

// MARK: - Translation
struct Translation: Codable {
	let translatedText: String
}
