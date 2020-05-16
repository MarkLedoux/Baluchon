//
//  TranslateTextViewDelegate.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 16/05/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

class TranslateTextViewDelegate: NSObject, UITextViewDelegate { 
	
}

class TranslateTextFieldDelegate: NSObject, UITextFieldDelegate { 
	// This function will be called when the textField object( jobTitleTextField ) begin editing.
	internal func textFieldDidBeginEditing(_ textField: UITextField) {
		print("textFieldDidBeginEditing")
	}
	
	// This function is called when you click return key in the text field.
	internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		return true
	}
}
