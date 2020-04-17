//
//  CurrencyViewController.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 06/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

final class CurrencyTableViewController: UITableViewController {
    let session = URLSession()

    /// setting up the navigation bar and instancing CurrencyNetworkManager
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCurrencyNetworkManager()
    }

    /// calling loadCurrency to fetch currency data
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        currencyNetworkManager.loadCurrency { result in
            switch result {
            case .success:
                print("Successfully fetched currency data")
            case .failure:
                print("Failed to fetch currency data")
            }
        }
    }

    // MARK: - Properties

    /// instantiating CurrencyNetworkManager for model-viewController communication
    private let currencyNetworkManager = CurrencyNetworkManager()

    /// instantiating CurrencyResult and setting properties to reload data of the tableView
    private var currencyResult: CurrencyResult? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Methods

    /// setting the number of rows to the count of rates
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyResult?.rates.count ?? 0
    }

    /// defining what cell needs to be returned  - line 51-60 need to be moved to a subclass of the cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        guard let currencyResult = currencyResult else { return UITableViewCell() }

        //sorting keys only results in values being off in the tableview
        let currencyBases = currencyResult.rates.map { "\($0) \($1)" }.sorted()

        let currencyValue = currencyBases[indexPath.row]

        cell.textLabel?.text = currencyValue
        return cell
    }

    // MARK: - Private Methods
    /// setup for the navigation bar
    private func setupNavigationBar() {
        navigationItem.title = "Currency"

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(edit))

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addItem))
    }

    /// setting up the delegate
    private func setupCurrencyNetworkManager() {
        currencyNetworkManager.delegate = self
    }

    @objc private func edit() {

    }

    @objc private func addItem() {

    }
}

extension CurrencyTableViewController: CurrencyDelegate {
    func didGetCurrencyData(currencyResult: CurrencyResult) {
        self.currencyResult = currencyResult
    }
}
