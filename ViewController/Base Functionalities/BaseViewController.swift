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
		view.addSubview(loadingIndicator!)
		loadingIndicator?.translatesAutoresizingMaskIntoConstraints = false
		
		loadingIndicator?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		loadingIndicator?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
	}
	
	func showLoadingIndicator() {
		loadingIndicator?.startAnimating() 
		
	}
	
	func hideLoadingIndicator() { 
		loadingIndicator?.stopAnimating()
	}
}
