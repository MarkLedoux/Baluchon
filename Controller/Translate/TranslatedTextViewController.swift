//
//  TranslatedTextViewController.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 19/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

class TranslatedTextViewController: UIViewController {
    @IBOutlet weak var translatedText: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
