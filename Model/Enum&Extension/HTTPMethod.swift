//
//  HTTPMethod.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 01/06/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

/// defining an Enum for possible request method cases
enum HTTPMethod: String {
	case get = "GET"
	case post = "POST"
	case put = "PUT"
	case patch = "PATCH"
	case delete = "DELETE"
}
