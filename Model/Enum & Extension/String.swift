//
//  String.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 23/07/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

extension String {
	var htmlDecoded: String {
		let decoded = try? NSAttributedString(data: Data(utf8), options: [
			.documentType: NSAttributedString.DocumentType.html,
			.characterEncoding: String.Encoding.utf8.rawValue
		], documentAttributes: nil).string
		
		return decoded ?? self
	}
}
