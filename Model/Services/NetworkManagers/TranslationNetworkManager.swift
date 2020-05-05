//
//  TranslationNetworkManager.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 16/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

class TranslationNetworkManager: NetworkManager {

    // MARK: - Public Properties
    /// setting up weather delegate
    weak var delegate: TranslateDelegate?

    // MARK: - Private Properties

    private var urlProvider = URLGeneratorForTranslate()
    private var request: URLRequest?
    private var textToTranslate: String?

    private var task: URLSessionDataTask?
    internal var session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    init(configuration: URLSessionConfiguration = .default) {
        session = URLSession(configuration: configuration)
    }

    ///test function to make the request work
    func makeRequest(
        textToTranslate: String,
        completion: @escaping(Result<TranslationResult, NetworkManagerError>) -> Void) {
        //TODO: - use guard for url 
        fetch(with: urlProvider.createTranslateURL()!, completion: completion)
    }
}
