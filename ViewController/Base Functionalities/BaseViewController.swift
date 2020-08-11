import UIKit

class BaseViewController: UIViewController { 
	private var loadingIndicator: UIActivityIndicatorView?
	override func viewDidLoad() {
		super.viewDidLoad()
		setupCloseKeyboardGestureRecognizer()
		setupLoadingIndicator()
	}
	
	@objc private func closeKeyboardOnTap() { 
		view.endEditing(true)
	}
	
	private func setupCloseKeyboardGestureRecognizer() { 
		let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboardOnTap))
		gestureRecognizer.cancelsTouchesInView = false
		view.addGestureRecognizer(gestureRecognizer)
	}
	
	private func setupLoadingIndicator() { 
		loadingIndicator = UIActivityIndicatorView() 
		loadingIndicator?.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(loadingIndicator!)
		loadingIndicator?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		loadingIndicator?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
	}
	
	func showLoadingIndicator() {
		setupLoadingIndicator()
		loadingIndicator?.startAnimating() 
		
	}
	
	func hideLoadingIndicator() { 
		loadingIndicator?.stopAnimating()
	}
	
	func presentTwoButtonsAlert(
		title: String, 
		defaultButtonTitle: String, 
		cancelButtonTitle: String, 
		onDefaultButtonTapAction: ((UIAlertAction) -> Void)?, 
		on viewController: UIViewController) {
		
		// Present an alert, which in a regular width environment is displayed as an alert
		let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
		
		alertController.addAction(UIAlertAction(
			title: defaultButtonTitle, 
			style: .default, 
			handler: onDefaultButtonTapAction))
		alertController.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil))
		
		viewController.present(alertController, animated: true, completion: nil)
	}
}
