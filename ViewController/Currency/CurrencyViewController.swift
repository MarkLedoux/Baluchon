//
//  CurrencyViewController.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 06/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

// swiftlint:disable weak_delegate
extension CurrencyViewController: CurrencyDelegate {
	func didGetCurrencyData(currencyResult: CurrencyResult) {
		currencyTableViewDataSource.currencyResult = currencyResult
		currencyTableView.reloadData()
	}
}

final class CurrencyViewController: UIViewController {

	@IBOutlet var currencyTableView: UITableView!

	/// setting up the navigation bar and instancing CurrencyNetworkManager
	override func viewDidLoad() {
		super.viewDidLoad()
		setupNavigationBar()
		setUpCurrencyNetworkManager()
		currencyTableView.dataSource = currencyTableViewDataSource
		currencyTableView.delegate = currencyTableViewDelegate
	}

	
	/// calling loadCurrency to fetch currency data
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		fetchCurrencuData()
	}

	private func handle(currencyResult: CurrencyResult) {
			currencyTableViewDataSource.currencyResult = currencyResult
			currencyTableView.reloadData()
	}

	// MARK: - Properties
	/// instantiating CurrencyNetworkManager for model-viewController communication
	private var currencyNetworkManager: CurrencyNetworkManager!

	private let currencyTableViewDataSource = CurrencyTableViewDataSource()
	private let currencyTableViewDelegate = CurrencyTableViewDelegate()

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

	private func setUpCurrencyNetworkManager() {
		let session = URLSession(configuration: .default)
		currencyNetworkManager = CurrencyNetworkManager(session: session)
	}
	
	private func fetchCurrencuData() {
		currencyNetworkManager.loadCurrency { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let currencyResult):
				DispatchQueue.main.async {
					self.handle(currencyResult: currencyResult)
				}
				print("Successfully fetched currency data")
			case .failure:
				self.fetchDataFailure(retry: true)
				print("Failed to fetch currency data")
			}
		}
	}

	@objc private func edit() { }

	@objc private func addItem() { }
	
	private func fetchDataFailure(retry: Bool) { 
		
		// Present an alert, which in a regular width environment is displayed as an alert
		let alert = UIAlertController(title: nil, message: "Failed to fetch Currency data", preferredStyle: .alert)
		
		// Ask the user if they want to try and load the data again if it failed 
		if retry { 
			alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { _ in
				self.fetchCurrencuData()
				self.retryButtonWasPressed()
			}))
		}
		
		alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
		
		present(alert, animated: true, completion: nil)
	}
	
	private func retryButtonWasPressed() { 
		dismiss(animated: true, completion: nil)
	}
}
