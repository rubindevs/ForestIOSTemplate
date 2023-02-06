//
//  File.swift
//  
//
//  Created by 염태규 on 2022/12/23.
//

import Foundation

public extension Date {
    
    func startOfMonth() -> Date? {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))
    }
    
    func endOfMonth() -> Date? {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth()!)
    }
    
    func moveMonth(index: Int) -> Date? {
        return Calendar.current.date(byAdding: .month, value: index, to: self)
    }
    
    func moveDay(index: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: index, to: self)
    }
    
    func set(year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil) -> Date? {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        components.year = year ?? self.year
        components.month = month ?? self.month
        components.day = day ?? self.day
        components.hour = hour ?? self.hour
        components.minute = minute ?? self.minute
        return Calendar.current.date(from: components)
    }
    
    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    // 1 sunday, 7 saturday
    var week: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    func dateString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    var days: [Date] {
        var values:[Date] = []
        if let _startDate = startOfMonth(), let _firstDate = _startDate.moveDay(index: -(_startDate.week - 1)) {
            print(_startDate)
            print(_firstDate)
            print(_startDate.week - 1)
            for i in 0..<42 {
                values.append(_firstDate.moveDay(index: i) ?? _firstDate)
            }
        }
        return values
    }
}
