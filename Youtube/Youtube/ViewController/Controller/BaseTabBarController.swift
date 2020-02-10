
import UIKit

class BaseTabbarController: UITabBarController {

    var homeNavigationViewcontroller = UINavigationController(rootViewController: HomeViewController())
    var trendingNavigationViewController = UINavigationController(rootViewController: TrendingViewController())
    var historyNavigationViewController = UINavigationController(rootViewController: HistoryViewController())
    func create(){
        homeNavigationViewcontroller.tabBarItem = UITabBarItem(title: "Home",
                                                               image: UIImage(named: "ico_home"),
                                                               tag: 0)
        trendingNavigationViewController.tabBarItem = UITabBarItem(title: "Trending", image: UIImage(named: "ico_trending"), tag: 1)
        historyNavigationViewController.tabBarItem = UITabBarItem(title: "History", image: UIImage(named: "ico_history"), tag: 2)
        self.viewControllers = [homeNavigationViewcontroller,trendingNavigationViewController,historyNavigationViewController]
        UITabBar.appearance().tintColor = .red
    }
}
