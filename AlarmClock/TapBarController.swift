import UIKit

enum Tabs: Int {
    case worldClocks
    case alarmClock
    case stopWatch
    case timer
}

final class TabBarController: UITabBarController {
    
    private func configure() {
        tabBar.tintColor = Resources.Colors.orange
    }
    
}
