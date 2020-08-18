//
//  CurrencyViewController.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 06/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

extension CurrencyViewController: CurrencyResultContainerDelegate {
	/// reloading the UITableView
	func didUpdateCurrencyData() {
		DispatchQueue.main.async {
			self.currencyTableView.reloadData()
		}
	}
}

extension CurrencyViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		// present alert with textfield
		promptForAnswer()
	}
	
	/// setting up the UITextField so the use can input an amount to change the currency value
	private func promptForAnswer() {
		let ac = UIAlertController(title: "Input a value", message: nil, preferredStyle: .alert)
		ac.addTextField { textField in
			textField.placeholder = "Input the currency value here..."
		}
		
		let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
			let answer = ac.textFields![0]
			// do something interesting with "answer" here
			guard
				let inputString = answer.text,
				let inputDouble = Double(inputString)
				else { return }
			self.selectedValue = inputDouble
		}
		ac.addAction(submitAction)
		present(ac, animated: true)
	}
}

final class CurrencyViewController: BaseViewController {
	
	/// default value to reload the UITableView with
	var selectedValue: Double = 1 {
		didSet {
			currencyTableViewDataSource.selectedValue = selectedValue
			currencyTableView.reloadData()
		}
	}
	
	@IBOutlet var currencyTableView: UITableView!
	
	/// setting up the navigation bar and instancing CurrencyNetworkManager
	override func viewDidLoad() {
		super.viewDidLoad()
		setupNavigationBar()
		setUpCurrencyNetworkManager()
		currencyTableView.dataSource = currencyTableViewDataSource
		currencyTableView.delegate = self
	}
	
	/// calling loadCurrency to fetch currency data
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		fetchCurrencyData()
	}
	
	/// reloading the UITableView once all the data has been fetched
	private func handle(currencyResult: CurrencyResult) {
		currencyTableViewDataSource.currencyResults = currencyResult
		currencyTableView.reloadData()
	} 
	
	// MARK: - Properties
	/// instantiating CurrencyNetworkManager for model-viewController communication
	private var currencyNetworkManager: CurrencyNetworkManager!
	
	/// create an instance of CurrencyTableViewDataSource()
	private let currencyTableViewDataSource = CurrencyTableViewDataSource()
	
	// MARK: - Private Methods
	/// setup for the navigation bar
	private func setupNavigationBar() {
		navigationItem.title = "Currency"
	}
	
	private func setUpCurrencyNetworkManager() {
		let session = URLSession(configuration: .default)
		currencyNetworkManager = CurrencyNetworkManager(session: session)
	}
	
	/// network call to fetch the currency data, presents an alert in case the call fails
	private func fetchCurrencyData() {
		showLoadingIndicator()
		currencyNetworkManager.loadCurrency { [weak self] result in
			guard let self = self else { return }
			DispatchQueue.main.async {
				switch result { 
				case .success(let currencyResult):
					self.hideLoadingIndicator()
					self.handle(currencyResult: currencyResult)
				case .failure:
					self.hideLoadingIndicator()
					self.onFetchCurrencyDataFailure()
				}
			}
		}
	}
	
	@objc private func onFetchCurrencyDataFailure() {
		presentAlertOnFetchDataFailure(
			title: "Failed to fetch data",
			defaultButtonTitle: "Retry", 
			cancelButtonTitle: "Cancel",  
			onDefaultButtonTapAction: onTryAgainAlertButtonTapAction(alertAction:),
			on: self)
	}
	
	/// option to try again if the current request fails
	/// - Parameter alertAction: UIAlertAction presented to the user
	private func onTryAgainAlertButtonTapAction(alertAction: UIAlertAction) {
		fetchCurrencyData()
		retryButtonWasPressed()
	}
	
	private func retryButtonWasPressed() { 
		dismiss(animated: true, completion: nil)
	}
}
