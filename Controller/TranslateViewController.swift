//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by Mark LEDOUX on 06/04/2020.
//  Copyright © 2020 vinceled. All rights reserved.
//

import UIKit

final class TranslateViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var translationInput: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func translationSend(_ sender: Any) {
        getTranslation { (success, translation) in
            if success, let translation = translation {
                self.update(translation: translation)
            } else  {
                self.presentAlert()
            }
        }
    }



    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Translate"
        self.dismissKey()

    }

    private func getTranslation(callback: @escaping (Bool, Translate?) -> Void) {

        let request = createTextRequest()

        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data, error == nil {
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    if let responsJSON = try? JSONDecoder().decode([String: String].self, from: data),
                        let text = responsJSON["translatedText"] {
                            let translation = Translate(source: "en", target: "fr", contents: [text], mimeType: "text")
                            callback(true, translation)
                    }
                }
            }
        }
        task.resume()
    }

    private func createTextRequest() -> URLRequest {
        let url = URL(string: "https://translation.googleapis.com/language/translate/v2?key=AIzaSyC-qFZOLKSpUQSmQS41iKGz8vJ7NXQKAFA")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let body = "q=getTranslation&source=en&target=es&format=json"
        request.httpBody = body.data(using: .utf8)

        return request
    }

    private func getUserInput() {
        translationInput.delegate  = self
        translationInput.placeholder = "Enter text"
        translationInput.clearButtonMode  = UITextField.ViewMode.always


    }

    // This function will be called when the textField object( jobTitleTextField ) begin editing.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
    }

    // This function is called when you click return key in the text field.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {


        return true
    }

    private func  update(translation: Translate) {
        let formattedTL = translation.contents
        let TLFormat = formattedTL.joined(separator: "")
        textView.text  = TLFormat
        print(TLFormat)
    }

    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "The quote download failed.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }

    func dismissKey() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        translationSend(translationInput)
        return true
    }

}
