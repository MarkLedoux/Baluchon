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
		translationInput.delegate = translationTextFieldDelegate
	}
}

// swiftlint:disable weak_delegate
final class TranslateViewController: UIViewController {
	
	// MARK: - Private Properties
	@IBOutlet private weak var sendTranslationButton: UIButton!
	@IBOutlet private weak var translationInput: UITextField!

	override func viewDidLoad() {
		super.viewDidLoad()
		setNavigationBar()
		setUpTranslationNetworkManager()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	private var translationNetworkManager: TranslationNetworkManager!
	private let translationTextFieldDelegate = TranslateTextFieldDelegate()
	private let translationTextViewDelegate = TranslateTextViewDelegate()
	private var translationResult: TranslationResult?
	private var targetText: String?

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
		if #available(iOS 13.0, *) {
			guard let vc = storyboard?.instantiateViewController(
				identifier: "TranslatedTextViewController", 
				creator: prepareTranslateDetailViewController) else { return }
			
			present(vc, animated: true, completion: nil)
		} else {
			// Fallback on earlier versions
		}
	}
	
	/// preparing the modal view to receive the translated text
	/// - Parameters:
	///   - segue: segue from translateViewController to TranslatedTextViewController
	///   - sender: send data from translateViewController after received it from the network request
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let vc = segue.destination as? TranslatedTextViewController

		guard let textToTranslate = translationInput.text else { return }
		translationNetworkManager.makeRequest(textToTranslate: textToTranslate) { result in
			switch result { 
			case .success(let translationResult): 
				DispatchQueue.main.async {
					vc?.translatedText.text = translationResult.translations.keys.description
				}
				print("Successfully fetched translation data")
			case .failure: 
				print("Failed to fetch translation data")
			}
		}
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
	
	@IBSegueAction func prepareTranslateDetailViewController(coder: NSCoder) -> TranslatedTextViewController { 
		return TranslatedTextViewController(coder: coder, text: translationResult?.translations.keys.description ?? "")!
	}
}
