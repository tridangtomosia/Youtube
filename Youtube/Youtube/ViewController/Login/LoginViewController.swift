
import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {

    @IBOutlet weak var signInButton: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
//        completeLogin()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        
    }
}


