//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 06/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

class WeatherViewController: UITableViewController {
    var weather = [Weather]()
    var keyArray = [String]()
    var valueArray = [Double]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Weather"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                           target: self, action: #selector(edit))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self, action: #selector(addItem))

        getWeatherData()
    }

    func getWeatherData() {
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=43e33607fe2ad4493bd13aeabd87e12f") {
            URLSession.shared.dataTask(with: url, completionHandler: {[unowned self] data, _, error in
                if let error = error { print(error); return }
                do {
                    let jsonCurrencies = try JSONDecoder().decode(Weather.self, from: data!)
                    self.weather = [jsonCurrencies]
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    print(error)
                }
            }).resume()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let weatherData = weather[indexPath.row]
        for (key, value) in weatherData.main {
            keyArray.append(key)
            valueArray.append(value)
            print(key)
        }
        let value = keyArray[indexPath.row]
        let key = valueArray[indexPath.row]
        cell.textLabel?.text = weatherData.name
        cell.detailTextLabel?.text = String(key)
        return cell
    }

    @objc func edit() {

    }

    @objc func addItem() {

    }

}
