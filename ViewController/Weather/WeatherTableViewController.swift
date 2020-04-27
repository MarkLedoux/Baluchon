//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 06/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        guard let weatherResult = weatherResult else { return UITableViewCell() }

        let weatherCity = weatherResult.name

        cell.textLabel?.text = weatherCity
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = cities[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
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
