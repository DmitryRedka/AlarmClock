//
//  Resources.swift
//  AlarmClock
//
//  Created by Дмитрий Редька on 04.03.2023.
//

import UIKit

enum Resources {
    enum Colors {
        static let orange = UIColor(hexString: "#F8A115")
        static let grey = UIColor(hexString: "#5E5E5E")
        static let darkGrey = UIColor(hexString: "302F2F")
    }
    
    enum Strings  {
        enum TabBar {
            static let worldClocks = "Мировые часы"
            static let alarmClock = "Будильник"
            static let stopWatch = "Секундомер"
            static let timer = "Таймер"
        }
    }
    
    enum Images {
        enum TabBar {
            static let worldClocks = UIImage(systemName: "globe")
            static let alarmClock = UIImage(systemName: "alarm.fill")
            static let stopWatch = UIImage(systemName: "stopwatch.fill")
            static let timer = UIImage(systemName: "timer")
        }
        enum NavBar {
            static let rightButton = UIImage(systemName: "plus")
        }
    }
}
