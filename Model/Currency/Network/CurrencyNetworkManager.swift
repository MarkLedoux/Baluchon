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
    weak var delegate: CurrencyDelegate?

    func loadCurrency() {
        if let url = URL(string: "http://data.fixer.io/api/latest?access_key=ec4830ae63993cf83fa637d7c488b1bf&symbols=EUR,USD,GBP,AUD,JPY") {
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
