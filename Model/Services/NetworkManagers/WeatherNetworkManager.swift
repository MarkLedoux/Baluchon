//
//  WeatherNetworkManager.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 14/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

class WeatherNetworkManager {

    // MARK: - Public Properties

    /// setting up weather delegate
    weak var delegate: WeatherDelegate?

    // MARK: - Private Properties
    private var urlComponents = URLGeneratorForWeather()

    private var task: URLSessionDataTask?
    private var session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    init(configuration: URLSessionConfiguration = .default) {
        session = URLSession(configuration: configuration)
    }

    /// fetching weather data and decoding it 
    func loadWeatherData(completion: @escaping(Result<WeatherResult, NetworkManagerError>) -> Void) {
        let url = createdURL()
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

    private func createdURL() -> URL {
        if let createdURL = urlComponents.createWeatherURL() {
            return createdURL
        }
        return createdURL()
    }
}
