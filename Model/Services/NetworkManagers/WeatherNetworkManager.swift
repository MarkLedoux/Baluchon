//
//  WeatherNetworkManager.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 14/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

class WeatherNetworkManager: NetworkManager {

    // MARK: - Public Properties

    /// setting up weather delegate
    weak var delegate: WeatherDelegate?

    // MARK: - Private Properties
    private var urlProvider = URLGeneratorForWeather()

    private var task: URLSessionDataTask?
    internal var session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    init(configuration: URLSessionConfiguration = .default) {
        session = URLSession(configuration: configuration)
    }

    /// fetching weather data and decoding it 
    func loadWeatherData(completion: @escaping(Result<WeatherResult, NetworkManagerError>) -> Void) {
        // TODO: - use guard for url 
        fetch(with: urlProvider.createWeatherURL()!, completion: completion)
    }
}
