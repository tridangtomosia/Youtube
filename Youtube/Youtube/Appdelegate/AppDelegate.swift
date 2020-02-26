
import UIKit
import GoogleSignIn

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window : UIWindow?
    let tabarController = BaseTabbarController()
    
    static var shared: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GIDSignIn.sharedInstance().clientID = "1062330148823-dommoo9682ce0aipjoqsi0k8oq13e494.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if UserDefaults.getIsLogin() {
            GIDSignIn.sharedInstance()?.restorePreviousSignIn()
            createHomeVC()
        } else {
            createLoginVC()
        }
        
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        return true
    }

    func createHomeVC() {
        tabarController.create()
        window?.rootViewController = tabarController
    }
    
    func createLoginVC() {
        window?.rootViewController = LoginViewController()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
}

extension AppDelegate : GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        UserDefaults.setIsLogin(value: true)
        createHomeVC()
    }
}

