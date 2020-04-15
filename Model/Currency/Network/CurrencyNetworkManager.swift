//
//  CurrencyNetworkManager.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 13/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

final class CurrencyNetworkManager {

    // MARK: - Public Properties
    /// setting up currency delegate
    weak var delegate: CurrencyDelegate?
    private var urlComponents = URLComponentManager()

    /// fetching currency data and decoding it 
    func loadCurrency() {
        if let url = urlComponents.createURL(
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
        ]) {
            URLSession.shared.dataTask(with: url, completionHandler: {[unowned self] data, _, error in
                if let error = error { print(error); return }
                do {
                    let currencyResult = try JSONDecoder().decode(CurrencyResult.self, from: data!)
                    self.delegate?.didGetCurrencyData(currencyResult: currencyResult)
                } catch {
                    print(error)
                }
            }).resume()
        }
    }
}
