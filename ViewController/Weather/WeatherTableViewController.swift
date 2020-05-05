//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 06/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

// swiftlint:disable force_cast
final class WeatherTableViewController: UITableViewController {
    var cities: [WeatherResult] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpWeatherNetworkManager()
        weatherNetWorkManager.loadWeatherData { result in
            switch result {
            case .success:
                print("Successfully fetched weather data")
            case .failure:
                print("Failed to fetch weather data")
            }
        }
    }

    // MARK: - Properties

    private let weatherNetWorkManager = WeatherNetworkManager()
    private var weatherResult: WeatherResult? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return weatherResult?.name.count ?? 0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherResult?.name.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherCell

        guard let weatherResult = weatherResult else { return UITableViewCell() }
        let mainWeather = weatherResult.main.map { (result) -> Main in
            let weatherMain = result
            return weatherMain
        }
        let weatherWeather = weatherResult.weather.map { (result) -> WeatherElement in
            let weathersWeather = result
            return weathersWeather
        }

        cell.temperatureLabel.text = mainWeather[indexPath.row].temp.description
        cell.weatherDescriptionLabel.text = weatherWeather[indexPath.row].description.description
        cell.cityNameLabel.text = weatherResult.name.description
        cell.weatherImageLabel.image = UIImage(named: "sleet")
        return cell
    }

    // MARK: - Private Methods

    private func setUpNavigationBar() {
        navigationItem.title = "Weather"

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(edit))

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addItem))
    }

    private func setUpWeatherNetworkManager() {
        weatherNetWorkManager.delegate = self
    }

    @objc private func edit() {

    }

    @objc private func addItem() {

    }
}

extension WeatherTableViewController: WeatherDelegate {
    func didGetWeatherData(weatherResult: WeatherResult) {
        self.weatherResult = weatherResult
    }
}
