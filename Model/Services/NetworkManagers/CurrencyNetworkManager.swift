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

    // MARK: - Public Methods
    /// fetching currency data and decoding it
    /// - Parameter completion: Result with CurrencyResult and NetworkManagerError
    func loadCurrency(completion: @escaping(Result<CurrencyResult, NetworkManagerError>) -> Void) {
        guard let url = url.createCurrencyURL() else {
            completion(.failure(.failedToCreateURL(message: #function)))
            assertionFailure("Failed to create URL \(#function)")
            return
        }
        fetch(with: url, completion: completion)
    }
}
