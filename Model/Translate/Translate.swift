//
//  Translate.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 13/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

struct Translate: Codable {
    let source: String
    let target: String
    let contents: [String]
    let mimeType: String
}

private enum CodingKeys: String, CodingKey {
    case source = "sourceLanguageCode"
    case target = "targetLanguageCode"
    case contents, mimeType
}
