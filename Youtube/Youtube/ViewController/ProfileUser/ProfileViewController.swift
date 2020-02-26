
import UIKit
import GoogleSignIn

class ProfileViewController: BaseViewController {
    @IBOutlet weak var inputNameTextField: UITextField!
    @IBOutlet weak var inputIDTextField: UITextField!
    @IBOutlet weak var inputEmailTextField: UITextField!
    @IBOutlet weak var clearHistoryButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    
    var response = ["Yes": false]
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        saveButton.gradientStyle(withStyle: .diagonalTop, firstColor: .gray, lastColor: .white)
        clearHistoryButton.gradientStyle(withStyle: .diagonalTop, firstColor: .gray, lastColor: .white)
        signOutButton.gradientStyle(withStyle: .diagonalTop, firstColor: .gray, lastColor: .white)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputIDTextField.text = UserID.shared.id
        inputNameTextField.text = UserID.shared.name
        inputEmailTextField.text = UserID.shared.email
    }
    
    @IBAction func didTapClose(sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapSignOut(sender: UIButton) {
        GIDSignIn.sharedInstance()?.signOut()
        UserDefaults.setIsLogin(value: false)
        AppDelegate.shared?.createLoginVC()
        dismiss(animated: true)
    }
    
    @IBAction func didTapRemoveHistory(sender: UIButton){
        let alertViewController = UIAlertController(title: "WARNING!!!",
                                                    message: "Clear All History, You Sure!",
                                                    preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .default)
        let okButton = UIAlertAction(title: "Clear", style: .default) { (action) in
            self.response["Yes"] = true
            NotificationCenter.default.post(name: NSNotification.Name("remove"), object: nil,
            userInfo: self.response)
        }
        alertViewController.addAction(okButton)
        alertViewController.addAction(cancelButton)
        present(alertViewController, animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name("remove"), object: nil,
            userInfo: self.response)
        }
    }
    
    @IBAction func didTapSave(sender: UIButton) {
        dismiss(animated: true)
    }
}
