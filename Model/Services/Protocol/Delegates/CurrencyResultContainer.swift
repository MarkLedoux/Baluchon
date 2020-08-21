//
//  CurrencyResultContainer.swift
//  BaluchonTests
//
//  Created by Mark LEDOUX on 11/08/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

/// Class with delegate to update the UITableView after the network request completes
class CurrencyResultContainer { 
	weak var delegate: CurrencyResultContainerDelegate?
	
	init(currencyResult: CurrencyResult) {
		self.currencyResult = currencyResult
	}
	
	var currencyResult: CurrencyResult { 
		didSet { 
			delegate?.didUpdateCurrencyData()
		}
	}
}
