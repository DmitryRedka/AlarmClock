import UIKit

enum Tabs: Int {
    case worldClocks
    case alarmClock
    case stopWatch
    case timer
}

final class TabBarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        tabBar.tintColor = Resources.Colors.orange
        tabBar.barTintColor = Resources.Colors.grey
        tabBar.backgroundColor = .black
        
        let worldClocksController = UIViewController()
        let alarmClockController = AlarmClockController()
        let stopWatchController = UIViewController()
        let timerController = UIViewController()
        
        let worldClocksNavigationController = UINavigationController(rootViewController: worldClocksController)
        let alarmClockNavigationController = UINavigationController(rootViewController: alarmClockController)
        let stopWatchNavigationController = UINavigationController(rootViewController: stopWatchController)
        let timerNavigationController = UINavigationController(rootViewController: timerController)
        
        worldClocksNavigationController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.worldClocks,
                                                        image: Resources.Images.TabBar.worldClocks,
                                                         tag: Tabs.worldClocks.rawValue)
        alarmClockNavigationController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.alarmClock,
                                                       image: Resources.Images.TabBar.alarmClock,
                                                       tag: Tabs.alarmClock.rawValue)
        stopWatchNavigationController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.stopWatch,
                                                      image: Resources.Images.TabBar.stopWatch,
                                                      tag: Tabs.stopWatch.rawValue)
        timerNavigationController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.timer,
                                                  image: Resources.Images.TabBar.timer,
                                                  tag: Tabs.timer.rawValue)
        setViewControllers([
            worldClocksNavigationController,
            alarmClockNavigationController,
            stopWatchNavigationController,
            timerNavigationController
        ], animated: false)
        
        alarmClockNavigationController.navigationBar.prefersLargeTitles = true
        alarmClockNavigationController.navigationBar.largeTitleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.white,
         .font: UIFont.boldSystemFont(ofSize: 34)]

    }
    
}
