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
		translationInputTextView.delegate = translationTextViewDelegate
	}
}

// swiftlint:disable weak_delegate
final class TranslateViewController: BaseViewController {
	
	// MARK: - Private Properties
	@IBOutlet private weak var sendTranslationButton: UIButton!
	@IBOutlet private weak var translationInputTextView: UITextView!
	@IBOutlet private weak var targetLanguageButton: UIButton!
	@IBOutlet private weak var inputLanguageButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setNavigationBar()
		setUpTranslationNetworkManager()
		translationInputTextView.layer.borderWidth = 1
		translationInputTextView.layer.borderColor = UIColor.black.cgColor
		translationInputTextView.layer.cornerRadius = 10
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	private var translationNetworkManager: TranslationNetworkManager!
	private var translationResult: TranslationResult?
	private var targetText: String?
	
	private let translationTextViewDelegate = TranslateTextViewDelegate()
	
	private var targetLanguage: Languages = .english {
		didSet {
			targetLanguageButton.setTitle(targetLanguage.title, for: .normal)
		}
	}
	
	private var sourceLanguage: Languages = .french {
		didSet {
			inputLanguageButton.setTitle(sourceLanguage.title, for: .normal)
		}
	}
	
	// MARK: - Private Methods
	
	private func setNavigationBar() {
		navigationItem.title = "Translate"
	}

	private func setUpTranslationNetworkManager() {
		let session = URLSession(configuration: .default)
		translationNetworkManager = TranslationNetworkManager(session: session)
	}
	
	@IBAction private func sendTextToTranslate(_ sender: Any) {
		animateButton(sendTranslationButton)
	}
	
	@IBAction private func switchInputAndTargetLanguage(_ sender: Any) {
		swap(&targetLanguage, &sourceLanguage)
	}
	
	private func fetchTranslateData(_ textToTranslate: String, _ vc: TranslatedTextViewController?) {
		translationNetworkManager.fetchTranslationData(
			source: sourceLanguage,
			target: targetLanguage,
		textToTranslate: textToTranslate) { result in
			switch result { 
			case .success(let translationResult): 
				DispatchQueue.main.async {
					vc?.hideLoadingIndicator()
					vc?.translatedText.text = translationResult.data.translations.first?.translatedText.htmlDecoded
				}
				print("Successfully fetched translation data")
			case .failure: 
				print("Failed to fetch translation data")
				self.perform(#selector(self.onFetchTranslationDataFailure), with: nil, afterDelay: 10)
			}
		}
	}
	
	/// preparing the modal view to receive the translated text
	/// - Parameters:
	///   - segue: segue from translateViewController to TranslatedTextViewController
	///   - sender: send data from translateViewController after received it from the network requestch
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let vc = segue.destination as? TranslatedTextViewController

		guard let textToTranslate = translationInputTextView.text else { return }
		guard textToTranslate != "" else { return }
		fetchTranslateData(textToTranslate, vc)
		vc?.showLoadingIndicator()
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
	
	@objc private func onFetchTranslationDataFailure() {
		presentTwoButtonsAlert(
			title: "Failure to fetch data", 
			message: "There was an error fetching the data", 
			defaultButtonTitle: "Retry", 
			cancelButtonTitle: "Cancel", 
			onDefaultButtonTapAction: onTryAgainAlertButtonTapAction(alertAction:),
			on: self)
		print("Failed to fetch currency data")
	}
	
	private func onTryAgainAlertButtonTapAction(alertAction: UIAlertAction) {
		retryButtonWasPressed()
	}
	
	private func retryButtonWasPressed() { 
		dismiss(animated: true, completion: nil)
	}
}
