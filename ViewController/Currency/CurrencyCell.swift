//
//  CurrencyCell.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 14/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

/// setup of th labels in the currency cell
class CurrencyCell: UITableViewCell {
	@IBOutlet var currencyRate: UILabel!
	@IBOutlet var currencyBase: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
}
