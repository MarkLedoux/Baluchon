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
    @IBOutlet weak var translatedText: UITextView!

    @IBAction func sendTextToTranslate(_ sender: Any) {
        guard let text = translationInput.text else { print("No text available"); return}

        let translation = Translate(source: "en", target: "es", q: text, mimeType: "text")

        sendTextRequest(translation) { (result) in
            switch result {
            case .failure(let error):
                print("An error occured \(error)")
            case .success:
                print("The text has been successfully sent")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Translate"

    }

    func sendTextRequest(
        _ textToSend: Translate,
        completion: @escaping(Result<Translate, NetworkManagerError>) -> Void) {

        let apiKey = "?key=AIzaSyC-qFZOLKSpUQSmQS41iKGz8vJ7NXQKAFA"
        let urlString = "https://translation.googleapis.com/language/translate/v2\(apiKey)&q=\(String(describing: translationInput.text))&&source=en&target=es"
        guard let url = URL(string: urlString) else { return }

        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = try JSONEncoder().encode(textToSend)

            let task = URLSession.shared.dataTask(with: request) { data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                    completion(.failure(.failedToFetchRessource))
                    return
                }

                do {
                    let textData = try JSONDecoder().decode(Translate.self, from: data)
                    completion(.success(textData))
                } catch {
                    completion(.failure(.failedToFetchRessource))
                }
            }
            task.resume()
        } catch {
            completion(.failure(.failedToFetchRessource))
        }
    }
}
