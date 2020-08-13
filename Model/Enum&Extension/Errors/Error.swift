//
//  Error.swift
//  BaluchonTests
//
//  Created by Mark LEDOUX on 11/08/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

extension Error {
	
	var isConnectivityError: Bool {
		// let code = self._code || Can safely bridged to NSError, avoid using _ members
		let code = (self as NSError).code
		
		if code == NSURLErrorTimedOut {
			return true // time-out
		}
		
		if self._domain != NSURLErrorDomain {
			return false // Cannot be a NSURLConnection error
		}
		
		switch code {
		case NSURLErrorNotConnectedToInternet, NSURLErrorNetworkConnectionLost, NSURLErrorCannotConnectToHost:
			return true
		default:
			return false
		}
	}	
}
