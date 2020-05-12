//
//  CurrencyTableViewDelegate.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 10/05/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

// swiftlint:disable force_cast
class CurrencyTableViewDataSource: NSObject, UITableViewDataSource {
	/// instantiating CurrencyResult and setting properties to reload data of the tableView
	var currencyResult: CurrencyResult?

	// MARK: - Methods

	/// setting the number of rows to the count of rates
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return currencyResult?.rates.count ?? 0
	}

	/// defining what cell needs to be returned  - line 51-60 need to be moved to a subclass of the cell
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CurrencyCell

		guard let currencyResult = currencyResult else { return UITableViewCell() }

		//sorting keys only results in values being off in the tableview
		let currencyBases = currencyResult.rates.map { "\($0) \($1)" }.sorted()

		let currencyValue = currencyBases[indexPath.row]

		cell.currencyBaseAndRate.text = currencyValue
		return cell
	}
}

class CurrencyTableViewDelegate: NSObject, UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

	}
}
