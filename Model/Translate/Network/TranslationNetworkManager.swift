//
//  TranslationNetworkManager.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 16/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

final class TranslationNetworkManager {

    // MARK: - Public Properties
    /// setting up weather delegate
    weak var delegate: TranslateDelegate?

    // MARK: - Private Properties

    private var urlComponents = URLComponentManager()
    private var request: URLRequest?

    private var task: URLSessionDataTask?
    var session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)

//    init(session: URLSession) {
//        self.session = session
//    }

    ///test function to make the request work
    func makeRequest(textToTranslate: String, completion: @escaping(_ results: [String: Any]?) -> Void) {
        if let url = urlComponents.createURL(
            scheme: "https",
            host: "translation.googleapis.com",
            path: "/language/translate/v2",
            queryItems: [
                URLQueryItem(name: "key", value: "AIzaSyC-qFZOLKSpUQSmQS41iKGz8vJ7NXQKAFA"),
                URLQueryItem(name: "q", value: textToTranslate),
                URLQueryItem(name: "source", value: "en"),
                URLQueryItem(name: "target", value: "fr")
        ]) {
            request = URLRequest(url: url)
            request?.httpMethod = "POST"
            task = session.dataTask(with: request!) { (results, response, error) in
                if error != nil {
                    completion(nil)
                } else {
                    if let response = response as? HTTPURLResponse, let results = results {
                        if response.statusCode == 200 || response.statusCode == 201 {
                            do {
                                if let resultsDict = try JSONSerialization.jsonObject(
                                    with: results,
                                    options: JSONSerialization.ReadingOptions.mutableLeaves) as? [String: Any] {
                                    completion(resultsDict)
                                }
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    } else {
                        completion(nil)
                    }
                }
            }
            task?.resume()
        }
    }

//    /// sending translation data
//    func sendTextRequestForTranslation(
//        completion: @escaping(Result<TranslationResult, NetworkManagerError>) -> Void) {
//
//        if let url = urlComponents.createURL(
//            scheme: "https",
//            host: "translation.googleapis.com",
//            path: "/language/translate/v2",
//            queryItems: [
//                URLQueryItem(name: "key", value: "AIzaSyC-qFZOLKSpUQSmQS41iKGz8vJ7NXQKAFA"),
//                URLQueryItem(name: "q", value: textToTranslate),
//                URLQueryItem(name: "source", value: "en"),
//                URLQueryItem(name: "target", value: "es")
//        ]) {
//            request = URLRequest(url: url)
//            request?.httpMethod = "POST"
//            request?.httpBody = try? JSONEncoder().encode(textToTranslate)
//
//            task = session.dataTask(with: request!) { (data, response, error) in
//                DispatchQueue.main.async {
//                    guard let data = data, error == nil else {
//                        completion(.failure(.failedToFetchRessource))
//                        return
//                    }
//
//                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                        completion(.failure(.failedToFetchRessource))
//                        return
//                    }
//
//                    guard let textData = try? JSONDecoder().decode(TranslationResult.self, from: data) else {
//                        completion(.failure(.failedToFetchRessource))
//                        return
//                    }
//                    self.delegate?.didFetchTranslationData(translationResult: textData)
//                }
//            }
//            task?.resume()
//        }
//    }
}
