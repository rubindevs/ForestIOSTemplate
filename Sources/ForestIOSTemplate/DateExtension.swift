//
//  File.swift
//  
//
//  Created by 염태규 on 2022/12/23.
//

import Foundation

public extension Date {
    
    public func startOfMonth() -> Date? {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))
    }
    
    public func endOfMonth() -> Date? {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth()!)
    }
    
    public func moveMonth(index: Int) -> Date? {
        return Calendar.current.date(byAdding: .month, value: index, to: self)
    }
    
    public func moveDay(index: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: index, to: self)
    }
    
    public func setDay(day: Int) -> Date? {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        components.day = day
        return Calendar.current.date(from: components)
    }
    
    // 1 sunday, 7 saturday
    public var week: Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    public var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    public var month: Int {
        return Calendar.current.component(.month, from: self)
    }
    
    public var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    public var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    public var dateSimpleString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        return dateFormatter.string(from: self)
    }
    
    public var timeString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: self)
    }
    
    public var monthString: String {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("MMM")
        return df.string(from: self)
    }
    
    public var days: [Date] {
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
