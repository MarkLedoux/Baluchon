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
		defaultButtonTitle:String, 
		cancelButtonTitle: String, 
		onDefaultButtonTapAction: ((UIAlertAction) -> Void)?, 
		on viewController: UIViewController)  {
		
		// Present an alert, which in a regular width environment is displayed as an alert
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		
		alertController.addAction(UIAlertAction(title: defaultButtonTitle, style: .default, handler: onDefaultButtonTapAction))
		alertController.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil))
		
		viewController.present(alertController, animated: true, completion: nil)
		
	}
	
	func presentSingleButtonAlert() {
		
	}
}
