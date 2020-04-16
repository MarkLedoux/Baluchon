//
//  CurrencyNetworkManager.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 13/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

 class CurrencyNetworkManager {

    // MARK: - Public Properties
    /// setting up currency delegate
    weak var delegate: CurrencyDelegate?

    // MARK: - Private Properties
    private var urlComponents = URLComponentManager()

    private var task: URLSessionDataTask?
    var session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)

//    init(session: URLSession) {
//        self.session = session
//    }

    /// fetching currency data and decoding it 
    func loadCurrency(completion: @escaping(Result<CurrencyResult, NetworkManagerError>) -> Void) {
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
            task?.cancel()
            task = session.dataTask(with: url) { (data, response, error) in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        completion(.failure(.failedToFetchRessource))
                        return
                    }

                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        completion(.failure(.failedToFetchRessource))
                        return
                    }

                    guard let currencyResult = try? JSONDecoder().decode(CurrencyResult.self, from: data) else {
                        completion(.failure(.failedToFetchRessource))
                        return
                    }

                    self.delegate?.didGetCurrencyData(currencyResult: currencyResult)
                }
            }
            task?.resume()
        }
    }
}
