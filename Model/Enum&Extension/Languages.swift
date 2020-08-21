//
//  Languages.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 30/07/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import Foundation

/// Enum for the languages used in the app for the translation
enum Languages: String { 
	case english = "en"
	case french = "fr"
	
	var title: String {
		switch self {	
		case .english: return "English"
		case .french: return "French"
		}
	}
}
