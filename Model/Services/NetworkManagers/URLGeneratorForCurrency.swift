//
//  URLComponentsForCurrency.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 19/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

final class URLGeneratorForCurrency {
    private var components = URLComponentManager()

    func createCurrencyURL() -> URL? {
        let currencyURL = components.createURL(
            scheme: "http",
            host: "data.fixer.io",
            path: "/api/latest",
            queryItems: [
                URLQueryItem(
                    name: "access_key",
                    value: "ec4830ae63993cf83fa637d7c488b1bf"),
                URLQueryItem(
                    name: "symbols",
                    value: "EUR,USD,GBP,AUD,JPY")
        ])
        return currencyURL
    }
}
