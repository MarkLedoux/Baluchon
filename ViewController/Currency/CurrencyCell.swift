//
//  CurrencyCell.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 14/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell {
	@IBOutlet var countryImage: UIImageView!
	@IBOutlet var currencyBaseAndRate: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

}
