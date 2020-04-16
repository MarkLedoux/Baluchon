//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 06/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

final class TranslateViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setUpTranslationNetworkManager()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        translationNetworkManager.sendTextRequestForTranslation { result in
            switch result {
            case .success:
                print("Successfully fetched translation data")
            case .failure(.failedToFetchRessource):
                print("Failed to fetch translation data")
            }
        }
    }

    // MARK: - Private Properties

    @IBOutlet private weak var translationInput: UITextField!
    @IBOutlet private weak var translatedText: UITextView!

    private let translationNetworkManager = TranslationNetworkManager()
    private var translationResult: TranslationResult?

    // MARK: - Private Methods

    private func setNavigationBar() {
        navigationItem.title = "Translate"
    }

    private func setUpTranslationNetworkManager() {
        translationNetworkManager.delegate = self
    }

    @IBAction func sendTextToTranslate(_ sender: Any) {
//        guard let text = translationInput.text else { print("No text available"); return}
//
//        let translation = TranslationResult(source: "en", target: "es", q: text, mimeType: "text")
//
//        sendTextRequest(translation) { (result) in
//            switch result {
//            case .failure(let error):
//                print("An error occured \(error)")
//            case .success:
//                print("The text has been successfully sent")
//            }
//        }
    }
}

extension TranslateViewController: TranslateDelegate {
    func didFetchTranslationData(translationResult: TranslationResult) {
        self.translationResult = translationResult
    }
}
