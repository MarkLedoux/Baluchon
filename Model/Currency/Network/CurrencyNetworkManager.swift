//
//  CurrencyNetworkManager.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 13/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

class CurrencyNetworkManager: NetworkManager {

    // MARK: - Public Properties
    /// setting up currency delegate
    weak var delegate: CurrencyDelegate?

    // MARK: - Private Properties
    internal var urlComponents = URLComponentManager()
    private var task: URLSessionDataTask?
    internal var session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    /// fetching currency data and decoding it
    /// - Parameter completion: Result with CurrencyResult and NetworkManagerError
    func loadCurrency(completion: @escaping(Result<CurrencyResult, NetworkManagerError>) -> Void) {

        //TODO: - extract url creation to a separate class and protocol
        // to create a general function like for Network Manager
        fetch(with: urlComponents.createURL(
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
        ])!, decode: { (data) -> CurrencyResult? in
            guard let currencyResult = data as? CurrencyResult else { return  nil }
            return currencyResult
        }, completion: completion)
    }
}
