//
//  Temperature.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 15/07/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

// MARK: - Temperature
struct Temperature {
	var degreesK: Double
	/// setting Celscius in comparion to Kelvin
	var degreesC: Double {
		return (degreesK - 273.15) 
	}
}
