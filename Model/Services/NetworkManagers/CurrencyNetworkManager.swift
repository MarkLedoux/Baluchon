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
        fetch(with: url.createCurrencyURL()!, completion: completion)
    }
}
