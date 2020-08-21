//
//  TranslateTextViewDelegate.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 16/05/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

class TranslateTextViewDelegate: NSObject, UITextViewDelegate { 
	// This function will be called when the textField object( jobTitleTextField ) begin editing.
	internal func textViewDidBeginEditing(_ textField: UITextView) {
		print("textFieldDidBeginEditing")
	}
	
	// This function is called when you click return key in the text field.
	internal func textViewShouldReturn(_ textField: UITextView) -> Bool {
		return true
	}
}
