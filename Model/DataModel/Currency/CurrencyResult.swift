//
//  Currency.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 06/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

// MARK: - Currency Data
struct CurrencyResult: Codable {
	let timestamp: Int
	let base: String
	let date: String
	let rates: [String: Double]
}

// MARK: - Currency Data Keys
private enum CodingKeys: String, CodingKey {
	case success, timestamp, base, date, rates
}

// MARK: - Currency Data Row 
struct CurrencyDataRow {
	let title: String
	let rate: Double
}
