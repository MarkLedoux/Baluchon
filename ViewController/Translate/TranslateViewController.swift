//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 06/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

extension TranslateViewController: TranslateDelegate {
	func didFetchTranslationData(translationResult: TranslationResult) {
		translationInput.delegate = translationTextViewDelegate
	}
}

// swiftlint:disable weak_delegate
final class TranslateViewController: UIViewController {
	
	// MARK: - Private Properties
	@IBOutlet private weak var sendTranslationButton: UIButton!
	@IBOutlet private weak var translationInput: UITextView!
	@IBOutlet weak var targetLanguage: UIButton!
	@IBOutlet weak var inputLanguage: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setNavigationBar()
		setUpTranslationNetworkManager()
		translationInput.layer.borderWidth = 1
		translationInput.layer.borderColor = UIColor.black.cgColor
		translationInput.layer.cornerRadius = 10
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	private var translationNetworkManager: TranslationNetworkManager!
	private var translationResult: TranslationResult?
	private var targetText: String?
	
	private let translationTextViewDelegate = TranslateTextViewDelegate()
	private let alertManager = AlertManager()

	// MARK: - Private Methods
	
	private func setNavigationBar() {
		navigationItem.title = "Translate"
	}

	private func setUpTranslationNetworkManager() {
		let session = URLSession(configuration: .default)
		translationNetworkManager = TranslationNetworkManager(session: session)
	}
	
	@IBAction func sendTextToTranslate(_ sender: Any) {
		animateButton(sendTranslationButton)
	}
	
	@IBAction func switchInputAndTargetLanguage(_ sender: Any) {
		let inputLanguageButtonText = inputLanguage.titleLabel?.text
		
		inputLanguage.setTitle(targetLanguage.titleLabel?.text, for: .normal)
		targetLanguage.setTitle(inputLanguageButtonText, for: .normal)
	}
	
	fileprivate func fetchTranslateData(_ textToTranslate: String, _ vc: TranslatedTextViewController?) {
		translationNetworkManager.fetchTranslationData(
		textToTranslate: textToTranslate) { result in
			switch result { 
			case .success(let translationResult): 
				DispatchQueue.main.async {
					vc?.translatedText.text = translationResult.data.translations.first?.translatedText.htmlDecoded
				}
				print("Successfully fetched translation data")
			case .failure: 
				print("Failed to fetch translation data")
			}
		}
	}
	
	/// preparing the modal view to receive the translated text
	/// - Parameters:
	///   - segue: segue from translateViewController to TranslatedTextViewController
	///   - sender: send data from translateViewController after received it from the network requestch
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let vc = segue.destination as? TranslatedTextViewController

		guard let textToTranslate = translationInput.text else { return }
		guard textToTranslate != "" else { return }
		fetchTranslateData(textToTranslate, vc)
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
	}
}
