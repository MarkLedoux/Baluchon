//
//  AlertManager.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 26/05/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

// TODO: - create specific file to handle all alerts for modularity

class AlertManager {
	
	func presentTwoButtonsAlert(
		title: String, 
		message: String, 
		defaultButtonTitle: String, 
		cancelButtonTitle: String, 
		onDefaultButtonTapAction: ((UIAlertAction) -> Void)?, 
		on viewController: UIViewController) {
		
		// Present an alert, which in a regular width environment is displayed as an alert
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		
		alertController.addAction(UIAlertAction(
			title: defaultButtonTitle, 
			style: .default, 
			handler: onDefaultButtonTapAction))
		alertController.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil))
		
		viewController.present(alertController, animated: true, completion: nil)
		
	}
	
	func presentSingleButtonAlert(title: String, message: String) {
		
	}
	
	func presentTextFieldAlert(on viewController: UIViewController) { 
		let alertController = UIAlertController(title: "Add New Name", message: "", preferredStyle: .alert)
		alertController.addTextField { (textField: UITextField!) -> Void in
			textField.placeholder = "Enter Second Name"
		}
		let saveAction = UIAlertAction(title: "Save", style: .default, handler: { _ -> Void in
			let firstTextField = alertController.textFields![0] as UITextField
			let secondTextField = alertController.textFields![1] as UITextField
			print("firstName \(firstTextField.text), secondName \(secondTextField.text)")
		})
		let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
		alertController.addTextField { (textField : UITextField!) -> Void in
			textField.placeholder = "Enter First Name"
		}
		
		alertController.addAction(saveAction)
		alertController.addAction(cancelAction)
		
		viewController.present(alertController, animated: true, completion: nil)
	}
}
