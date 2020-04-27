//
//  TranslationNetworkManager.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 16/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

class TranslationNetworkManager {

    // MARK: - Public Properties
    /// setting up weather delegate
    weak var delegate: TranslateDelegate?

    // MARK: - Private Properties

    private var urlComponents = URLGeneratorForTranslate()
    private var request: URLRequest?
    private var textToTranslate: String?

    private var task: URLSessionDataTask?
    private var session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    init(configuration: URLSessionConfiguration = .default) {
        session = URLSession(configuration: configuration)
    }

    ///test function to make the request work
    func makeRequest(textToTranslate: String, completion: @escaping(_ results: [String: Any]?) -> Void) {
        if let url = urlComponents.createTranslateURL() {
            request = URLRequest(url: url)
            request?.httpMethod = "POST"
            task = session.dataTask(with: request!) { (data, response, error) in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        completion(nil)
                        return
                }

                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        completion(nil)
                        return
                    }

                    guard let translationData = try? JSONSerialization.jsonObject(
                        with: data,
                        options: JSONSerialization.ReadingOptions.mutableLeaves) as? [String: Any] else {
                        completion(nil)
                        return
                    }
                    self.delegate?.didFetchTranslationData(translationResult: translationData)
                }
            }
            task?.resume()
        }
    }
}
