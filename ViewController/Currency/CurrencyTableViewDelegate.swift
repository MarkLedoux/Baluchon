//
//  CurrencyTableViewDelegate.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 10/05/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

protocol CurrencyResultContainerDelegate: class { 
	func didUpdateCurrencyData()
}

class CurrencyResultContainer { 
	weak var delegate: CurrencyResultContainerDelegate?
	
	init(currencyResult: CurrencyResult) {
		self.currencyResult = currencyResult
	}
	
	var currencyResult: CurrencyResult { 
		didSet { 
			delegate?.didUpdateCurrencyData()
		}
	}
	
}

struct CurrencyDataRow {
	let title: String
	let rate: Double
}

// swiftlint:disable force_cast
final class CurrencyTableViewDataSource: NSObject, UITableViewDataSource {
	var selectedValue: Double = 100
	/// instantiating CurrencyResult and setting properties to reload data of the tableView
	var currencyResults: CurrencyResult?

	var dataToPresent: [CurrencyDataRow] {
		guard let currencyResults = currencyResults else { return [] }
		return currencyResults.rates.map {
			CurrencyDataRow(title: $0, rate: $1)
		}
	}
	// MARK: - Methods

	/// setting the number of rows to the count of rates
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataToPresent.count 
	}

	/// defining what cell needs to be returned  - line 51-60 need to be moved to a subclass of the cell
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CurrencyCell

		let currencyResult = dataToPresent[indexPath.row]

		//sorting keys only results in values being off in the tableview
		let currencyBase = currencyResult.title
		
		let currencyValue = currencyResult.rate * selectedValue
		
		cell.currencyBase.text = currencyValue.description
		cell.currencyRate.text = currencyBase
		return cell
	}
	
	func tableView(
		_ tableView: UITableView, 
		commit editingStyle: UITableViewCell.EditingStyle, 
		forRowAt indexPath: IndexPath) { }
}

//final class CurrencyTableViewDelegate: NSObject, UITableViewDelegate {
//	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		
//	}
//}
