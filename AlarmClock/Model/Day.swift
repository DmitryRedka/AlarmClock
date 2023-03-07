//
//  Day.swift
//  AlarmClock
//
//  Created by Дмитрий Редька on 05.03.2023.
//

import Foundation

enum Day:Int, Codable, CaseIterable{
    case Sun = 0,Mon,Tue,Wed,Thu,Fri,Sat
    
    var dayString:String{
        switch self {
            case .Sun: return "Каждое воскресенье"
            case .Mon: return "Каждый понедельник"
            case .Tue: return "Каждый вторник"
            case .Wed: return "Каждая среда"
            case .Thu: return "Каждый четверг"
            case .Fri: return "Каждая пятница"
            case .Sat: return "Каждая суббота"
        }
    }
    
    var dayText:String{
        switch self {
            case .Sun: return "Вс"
            case .Mon: return "Пн"
            case .Tue: return "Вт"
            case .Wed: return "Ср"
            case .Thu: return "Чт"
            case .Fri: return "Пт"
            case .Sat: return "Сб"
        }
    }
    
    var componentWeekday: Int {
        switch self {
            case .Sun: return 1
            case .Mon: return 2
            case .Tue: return 3
            case .Wed: return 4
            case .Thu: return 5
            case .Fri: return 6
            case .Sat: return 7
        }
    }
    
}
