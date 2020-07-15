//
//  Temperature.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 15/07/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

struct Temperature {
	var degreesK: Double {
		didSet {
			if degreesK > 400 {
				print("It's \(degreesK) degrees Fahrenheit! I had fun coding in Swift with you before I melted.")
			}
		}
	}
	
	var degreesC: Double {
		get { return (degreesK - 273.15) }
		set { degreesK = newValue + 273.15 }
	}
}
