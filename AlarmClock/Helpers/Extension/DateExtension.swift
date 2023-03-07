//
//  DateExtension.swift
//  AlarmClock
//
//  Created by Дмитрий Редька on 05.03.2023.
//

import Foundation
extension Date{
    
    func toString(format: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    var localizedDescription: String {
        return description(with: .current)
    }

}
