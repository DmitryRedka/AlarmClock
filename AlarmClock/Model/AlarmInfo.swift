//
//  AlarmInfo.swift
//  AlarmClock
//
//  Created by Дмитрий Редька on 05.03.2023.
//

import Foundation
import UserNotifications



struct AlarmInfo:Codable{
    
    var id = UUID()
    var date:Date = Date()
    var note:String = "Будильник"
    var noteLabel:String{
        if repeatDay == "Никогда"{
            return note
        }
        return note + ", " + repeatDay
    }
   
    var isOn: Bool = true {
        didSet{
            if isOn{
            }else{
                
                UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["\(self.id.uuidString)"])
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["\(self.id.uuidString)"])
            }
        }
    }
    
    var selectDays:Set<Day> = []
    
    var isEdit = false
    
    var repeatDay:String{
        switch selectDays{
        case [.Sat, .Sun]:
            return "Будни"
        case [.Sun, .Mon, .Tue, .Wed, .Thu, .Fri, .Sat]:
            return "Каждый день"
        case [.Mon, .Tue, .Wed, .Thu, .Fri]:
            return "Выходные"
        case []:
            return "Никогда"
        default:
            let day = selectDays.sorted(by: {$0.rawValue < $1.rawValue}).map{$0.dayText}.joined(separator: " ")
            return day
        }
    }
}

