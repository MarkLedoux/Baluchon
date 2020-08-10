//
//  TranslateDelegate.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 16/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

// MARK : - Translation Delegate Protocol
protocol TranslateDelegate: class {
	func didFetchTranslationData(translationResult: TranslationResult)
}
