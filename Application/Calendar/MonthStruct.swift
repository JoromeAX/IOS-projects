//
//  MonthStruct.swift
//  Calendar
//
//  Created by Roman Khancha on 29.03.2023.
//

import Foundation

struct MonthStruct {
    
    var monthType: MonthType
    var dayInt: Int
    func dayString() -> String {
        String(dayInt)
    }
}

enum MonthType {
    case Previous
    case Current
    case Next
}
