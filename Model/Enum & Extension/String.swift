//
//  String.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 23/07/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

extension String {
	func encodeUrl() -> String? {
		return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
	}
	
	func decodeUrl() -> String? {
		return self.removingPercentEncoding
	}
}
