import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func alert(withTitle title: String, withMessage message: String ) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .default)
        alertViewController.addAction(cancelButton)
        present(alertViewController, animated: true) {
        }
    }
}
