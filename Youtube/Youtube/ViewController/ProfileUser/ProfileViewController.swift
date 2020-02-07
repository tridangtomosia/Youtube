
import UIKit
import GoogleSignIn

class ProfileViewController: BaseViewController {
    @IBOutlet weak var inputNameTextField: UITextField!
    @IBOutlet weak var inputIDTextField: UITextField!
    @IBOutlet weak var inputEmailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        inputIDTextField.text = GIDSignIn.sharedInstance()?.currentUser.userID
        inputNameTextField.text = GIDSignIn.sharedInstance()?.currentUser.profile.name
        inputEmailTextField.text = GIDSignIn.sharedInstance()?.currentUser.profile.email
    }
    
    @IBAction func didTapClose(sender: UIButton) {
        dismiss(animated: true) { }
    }
    
    @IBAction func didTapSignOut(sender: UIButton) {
        GIDSignIn.sharedInstance()?.signOut()
        UserDefaults.setIsLogin(value: false)
        AppDelegate.shared?.createLoginVC()
        dismiss(animated: true) { }
    }
    
    @IBAction func didTapSave(sender: UIButton) {
        dismiss(animated: true) { }
    }
}
