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
    let source: String
    let target: String
    let q: [String]
    let mimeType: String
    let translations: [String: String]
    let translatedText: String
}

/// definining keys for the translation data 
private enum CodingKeys: String, CodingKey {
    case source = "sourceLanguageCode"
    case target = "targetLanguageCode"
    case q, mimeType, translations, translatedText
}
