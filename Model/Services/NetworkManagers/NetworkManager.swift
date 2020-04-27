//
//  NetworkManager.swift
//  BaluchonTests
//
//  Created by Mark LEDOUX on 16/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

protocol NetworkManager: class {
    var session: URLSession { get }
    func fetch<T: Codable>(
        with url: URL,
        decode: @escaping(Codable) -> T?,
        completion: @escaping(Result<T, NetworkManagerError>) -> Void)
}

extension NetworkManager {
    typealias TaskCompletionHander = (Codable?, NetworkManagerError?) -> Void
    private func decodingTask<T: Codable>(
        with url: URL,
        decodingType: T.Type,
        completionHandler completion: @escaping TaskCompletionHander) -> URLSessionDataTask {

       let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(nil, .requestFailed)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(nil, .responseUnsuccessful)
                    return
                }
                guard (try? JSONDecoder().decode(decodingType, from: data)) != nil else {
                    completion(nil, .jsonConversionFailure)
                    return
                }
            }
        }
        return task
    }

    func fetch<T: Codable>(
        with url: URL,
        decode: @escaping (Codable) -> T?,
        completion: @escaping (Result<T, NetworkManagerError>) -> Void) {

        let task = decodingTask(with: url, decodingType: T.self) { (result, error) in
            DispatchQueue.main.async {
                guard let result = result else {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(.invalidData))
                    }
                    return
                }
                if let value = decode(result) {
                    completion(.success(value))
                } else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
        task.resume()
    }
}
