//
//  CurrencyViewController.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 06/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

final class CurrencyViewController: UITableViewController {
   private var currency = [Currency]()
   private var keyArray = [String]()
   private var valueArray = [Double]()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Currency"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                           target: self, action: #selector(edit))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self, action: #selector(addItem))

        loadCurrency()

    }

   private func loadCurrency() {
        if let url = URL(string: "http://data.fixer.io/api/latest?access_key=ec4830ae63993cf83fa637d7c488b1bf") {
            URLSession.shared.dataTask(with: url, completionHandler: {[unowned self] data, _, error in
                if let error = error { print(error); return }
                do {
                    let jsonCurrencies = try JSONDecoder().decode(Currency.self, from: data!)
                    self.currency = [jsonCurrencies]
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
        return currency.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let currencies = currency[indexPath.row]
        for (key, value) in currencies.rates {
            keyArray.append(key)
            valueArray.append(value)
            print(key)
        }
        let value = keyArray[indexPath.row]
        let key = valueArray[indexPath.row]
        cell.textLabel?.text = value
        cell.detailTextLabel?.text = String(key)
        return cell
    }

    @objc private func edit() {

    }

    @objc private func addItem() {

    }

}
