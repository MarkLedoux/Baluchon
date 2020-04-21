//
//  WeatherNetworkManager.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 14/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

final class WeatherNetworkManager {

    // MARK: - Public Properties

    /// setting up weather delegate
    weak var delegate: WeatherDelegate?

    // MARK: - Private Properties
    private var urlComponents = URLComponentManager()

    private var task: URLSessionDataTask?
    var session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)

    //    init(session: URLSession) {
    //        self.session = session
    //    }

    /// fetching weather data and decoding it 
    func loadWeatherData(completion: @escaping(Result<WeatherResult, NetworkManagerError>) -> Void) {
        if let url = urlComponents.createURL(
            scheme: "http",
            host: "api.openweathermap.org",
            path: "/data/2.5/weather",
            queryItems: [
                URLQueryItem(
                    name: "q",
                    value: "London,uk"),
                URLQueryItem(
                    name: "APPID",
                    value: "43e33607fe2ad4493bd13aeabd87e12f")
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

                    guard let weatherResult = try? JSONDecoder().decode(WeatherResult.self, from: data) else {
                        completion(.failure(.failedToFetchRessource))
                        return
                    }
                    self.delegate?.didGetWeatherData(weatherResult: weatherResult)
                }
            }
            task?.resume()
        }
    }
}
