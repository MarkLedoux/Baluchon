//
//  String.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 23/07/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

/// Used to decode the text given back on translation network call
extension String {
	var htmlDecoded: String {
		guard let decoded = try? NSAttributedString(data: Data(utf8), options: [
			.documentType: NSAttributedString.DocumentType.html,
			.characterEncoding: String.Encoding.utf8.rawValue
		], documentAttributes: nil).string else { return "" }
		return decoded
	}
}
