//
//  CurrencyViewController.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 06/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

// swiftlint:disable weak_delegate
extension CurrencyViewController: CurrencyResultContainerDelegate {
	func didUpdateCurrencyData() {
		DispatchQueue.main.async {
			self.currencyTableView.reloadData()
		}
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
		fetchCurrencyData()
	}
	
	private func handle(currencyResult: [String: CurrencyResult]) {
		currencyTableViewDataSource.currencyResults = currencyResult
			.map { $0.value }
			.map { 
				let container = CurrencyResultContainer(currencyResult: $0)
				container.delegate = self
				return container
		}
		currencyTableView.reloadData()
	}
	
	// MARK: - Properties
	/// instantiating CurrencyNetworkManager for model-viewController communication
	private var currencyNetworkManager: CurrencyNetworkManager!
	
	private let currencyTableViewDataSource = CurrencyTableViewDataSource()
	private let currencyTableViewDelegate = CurrencyTableViewDelegate()
	private let alertManager = AlertManager()
	
	// MARK: - Private Methods
	/// setup for the navigation bar
	private func setupNavigationBar() {
		navigationItem.title = "Currency"
	}
	
	private func setUpCurrencyNetworkManager() {
		let session = URLSession(configuration: .default)
		currencyNetworkManager = CurrencyNetworkManager(session: session)
	}
	
	private func fetchCurrencyData() {
		currencyNetworkManager.loadMultipleCurrencies(
		currencyBaseNames: ["EUR", "USD", "GBP", "JPY"]) { [weak self] result in
			guard let self = self else { return }
			switch result { 
			case .success(let currencyResultDic):
				DispatchQueue.main.async {
					self.handle(currencyResult: currencyResultDic)
				}
				print("Successfully fetched currency data")
			case .failure:
				self.onFetchCurrencyDataFailure()
			}
		}
	}
	
	private func onFetchCurrencyDataFailure() {
		alertManager.presentTwoButtonsAlert(
			title: "Failure to fetch data", 
			message: "", 
			defaultButtonTitle: "", 
			cancelButtonTitle: "", 
			onDefaultButtonTapAction: onTryAgainAlertButtonTapAction(alertAction:),
			on: self)
		print("Failed to fetch currency data")
	}
	
	private func onTryAgainAlertButtonTapAction(alertAction: UIAlertAction) {
		fetchCurrencyData()
		retryButtonWasPressed()
	}
	
	@objc private func edit() { }
	
	@objc private func addItem() { }
	
	private func retryButtonWasPressed() { 
		dismiss(animated: true, completion: nil)
	}
}
