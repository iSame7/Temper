//
//  Date+Extenstions.swift
//  Temper
//
//  Created by Sameh Mabrouk on 18/12/2019.
//  Copyright © 2019 Sameh Mabrouk. All rights reserved.
//

import Foundation

extension Date {
    /// Returns a Date with the specified amount of components added to the one it is called with
    func add(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date? {
        let components = DateComponents(year: years, month: months, day: days, hour: hours, minute: minutes, second: seconds)
        return Calendar.current.date(byAdding: components, to: self)
    }
    
    /// Converts a date to a string formatted to "yyyy-MM-dd"
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
