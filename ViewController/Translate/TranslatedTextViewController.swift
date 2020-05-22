//
//  TranslatedTextViewController.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 19/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

class TranslatedTextViewController: UIViewController {
	let textToDisplay: String
	@IBOutlet weak var translatedText: UITextView!
	
	init?(coder: NSCoder, text: String) { 
		self.textToDisplay = translatedText.text
		super.init(coder: coder)
	}
	
	required init?(coder: NSCoder) {
		self.textToDisplay = ""
		super.init(coder: coder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	@IBAction func dismiss(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
}
