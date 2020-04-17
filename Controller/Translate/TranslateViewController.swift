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

    }

    // MARK: - Private Properties

    @IBOutlet weak var sendTranslationButton: UIButton!
    @IBOutlet private weak var translationInput: UITextField!
    @IBOutlet private weak var translatedText: UITextView!

    private let translationNetworkManager = TranslationNetworkManager()
    private var translationResult: TranslationResult?
    private var targetText: String?

    // MARK: - Private Methods

    private func setNavigationBar() {
        navigationItem.title = "Translate"
    }

    private func setUpTranslationNetworkManager() {
        translationNetworkManager.delegate = self
    }

    @IBAction func sendTextToTranslate(_ sender: Any) {
        animateButton(sendTranslationButton)
        translationNetworkManager.sendTextRequestForTranslation { translation in
            switch translation {
            case .success:
                print("Translation data was successfully sent")
            case .failure:
                print("Failed to fetch translation data")
            }
        }
    }

    // This function will be called when the textField object( jobTitleTextField ) begin editing.
    internal func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
    }

    // This function is called when you click return key in the text field.
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }

    /// button animation on tap when sending request
    /// - Parameter sender: sendTranslationButton as UIButton
    private func animateButton(_ sender: UIButton) {
        UIButton.animate(
            withDuration: 0.2,
            animations: {
                sender.transform = CGAffineTransform(scaleX: 0.975, y: 0.96)}, completion: { _ in
                    UIButton.animate(withDuration: 0.2, animations: { sender.transform = CGAffineTransform.identity })
        })
        buttonDesign()
    }

    /// rounding corners of the button used to send the translation request
    private func buttonDesign() {
        sendTranslationButton.layer.cornerRadius = 4
        sendTranslationButton.clipsToBounds = true
    }
}

extension TranslateViewController: TranslateDelegate {
    func didFetchTranslationData(translationResult: TranslationResult) {
        self.translationResult = translationResult
    }
}
