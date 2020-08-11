import UIKit

/// Base UIViewController giving functionalities to all UIViewControllers in the app
class BaseViewController: UIViewController { 
	private var loadingIndicator: UIActivityIndicatorView?
	override func viewDidLoad() {
		super.viewDidLoad()
		setupCloseKeyboardGestureRecognizer()
		setupLoadingIndicator()
	}
	
	/// closing keyboard when tapping outside 
	@objc private func closeKeyboardOnTap() { 
		view.endEditing(true)
	}
	
	/// setting up the tap gesture to be able  to close the keyboard
	private func setupCloseKeyboardGestureRecognizer() { 
		let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboardOnTap))
		gestureRecognizer.cancelsTouchesInView = false
		view.addGestureRecognizer(gestureRecognizer)
	}
	
	/// setup of  the UIActivityIndicator so it can be called when the network call is ongoing
	private func setupLoadingIndicator() { 
		loadingIndicator = UIActivityIndicatorView() 
		loadingIndicator?.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(loadingIndicator!)
		loadingIndicator?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		loadingIndicator?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
	}
	
	/// Showing the UIActivityIndicator on the view
	func showLoadingIndicator() {
		setupLoadingIndicator()
		loadingIndicator?.startAnimating() 
		
	}
	
	/// Hiding the UIActivityIndicator once the request succeeds 
	func hideLoadingIndicator() { 
		loadingIndicator?.stopAnimating()
	}
	
	/// Alert used when fetching the data on the network call fails
	/// - Parameters:
	///   - title: informing the user what went wrong 
	///   - defaultButtonTitle: giving the option to retry
	///   - cancelButtonTitle: giving the option to cancel
	///   - onDefaultButtonTapAction: method to call when the user taps retry
	///   - viewController: viewController used to present to UIAlert
	func presentAlertOnFetchDataFailure(
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
	
	func presentSingleButtonAlertOnRequestFailure(
		title: String, 
		cancelButtonTitle: String, 
		on viewController: UIViewController) { 
		let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
		
		alertController.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil))
		
		viewController.present(alertController, animated: true, completion: nil)
	}
}
