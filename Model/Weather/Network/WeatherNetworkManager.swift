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

    weak var delegate: WeatherDelegate?

    func loadWeatherData() {
        let apiKey = "&APPID=43e33607fe2ad4493bd13aeabd87e12f"
        let urlString = "http://api.openweathermap.org/data/2.5/weather?q=London,uk\(apiKey)"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: {[unowned self] data, _, error in
                if let error = error { print(error); return }
                do {
                    let weatherResult = try JSONDecoder().decode(WeatherResult.self, from: data!)
                    self.delegate?.didGetWeatherData(weatherResult: weatherResult)
                } catch {
                    print(error)
                }
            }).resume()
        }
    }
}
