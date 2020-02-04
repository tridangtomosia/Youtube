
import UIKit
import GoogleSignIn

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window : UIWindow?
    var homeNavigationViewcontroller: UINavigationController!
    var trendingNavigationViewController: UINavigationController!
    var historyNavigationViewController: UINavigationController!
    let tabarController = UITabBarController()
    
    static var shared: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
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
        homeNavigationViewcontroller = UINavigationController(rootViewController: HomeViewController())
        trendingNavigationViewController = UINavigationController(rootViewController: TrendingViewController())
        historyNavigationViewController = UINavigationController(rootViewController: HistoryViewController())
        homeNavigationViewcontroller?.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "ico_home"), tag: 0)
        trendingNavigationViewController?.tabBarItem = UITabBarItem(title: "Trending", image: UIImage(named: "ico_trending"), tag: 1)
        historyNavigationViewController?.tabBarItem = UITabBarItem(title: "History", image: UIImage(named: "ico_history"), tag: 2)
        tabarController.viewControllers = [homeNavigationViewcontroller,trendingNavigationViewController,historyNavigationViewController]
        UITabBar.appearance().tintColor = .red
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
            NotificationCenter.default.post( name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
            return
        }
        
        let user = User(name: user.profile.name, identification: user.userID, email: user.profile.email)
        
        UserDefaults.setIsLogin(value: true)
        NotificationCenter.default.post( name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil,
                                         userInfo: ["statusText": "Signed in user:\n\(user.name)"])
        
        createHomeVC()
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "ToggleAuthUINotification"),
            object: nil,
            userInfo: ["statusText": "User has disconnected."])
    }
}

