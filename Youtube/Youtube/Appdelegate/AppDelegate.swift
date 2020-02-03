
import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    
//    [GIDSignIn sharedInstance].clientID = @"1062330148823-dommoo9682ce0aipjoqsi0k8oq13e494.apps.googleusercontent.com";

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        return true
        
        
    }

  
}


