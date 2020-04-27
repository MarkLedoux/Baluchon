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
    private var url = URLGeneratorForCurrency()
    private var task: URLSessionDataTask?
    internal var session: URLSession

    // MARK: - Init
    init(session: URLSession) {
        self.session = session
    }

    init(configuration: URLSessionConfiguration = .default) {
        session = URLSession(configuration: configuration)
    }

    // MARK: - Public Methods
    /// fetching currency data and decoding it
    /// - Parameter completion: Result with CurrencyResult and NetworkManagerError
    func loadCurrency(completion: @escaping(Result<CurrencyResult, NetworkManagerError>) -> Void) {
        if let createdURL = url.createCurrencyURL() {
            task?.cancel()
            task = session.dataTask(with: createdURL) { (data, response, error) in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        completion(.failure(.failedToFetchRessource))
                        return
                    }

                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        completion(.failure(.responseUnsuccessful))
                        return
                    }

                    guard let currencyResult = try? JSONDecoder().decode(CurrencyResult.self, from: data) else {
                        completion(.failure(.jsonConversionFailure))
                        return
                    }
                    self.delegate?.didGetCurrencyData(currencyResult: currencyResult)
                }
            }
            task?.resume()
        }
    }

    func loadCurrencyTest(completion: @escaping(Result<CurrencyResult, NetworkManagerError>) -> Void) {
        fetch(with: url.createCurrencyURL()!, decode: { (data) -> CurrencyResult? in
            guard let currencyResult = data as? CurrencyResult else { return nil }
            return currencyResult
        }, completion: completion)
    }
}
