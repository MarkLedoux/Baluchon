//
//  Currency.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 06/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

struct CurrencyResult: Codable {
    let timestamp: Int
    let base: String
    let date: String
    let rates: [String: Double]
}

private enum CodingKeys: String, CodingKey {
    case success, timestamp, base, date, rates
}
