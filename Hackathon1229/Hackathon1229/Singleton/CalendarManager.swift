//
//  CalendarManager.swift
//  Hackathon1229
//
//  Created by 김호성 on 2024.12.29.
//

import Foundation

class CalendarManager {
    private init() { }
    
    public static let shared = CalendarManager()
    
    func getDaysOfYear() -> Int {
        
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        
        let startOfYear = calendar.date(from: DateComponents(year: currentYear, month: 1, day: 1))!
        let endOfYear = calendar.date(from: DateComponents(year: currentYear, month: 12, day: 31))!
        
        let daysOfYear = calendar.dateComponents([.day], from: startOfYear, to: endOfYear).day! + 1

        return daysOfYear
    }
    
    func toString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "M월 d일 EEEE"
        return formatter.string(from: date)
    }
    
    func getISO8601DateFormatter() -> String {
        let now = Date()

        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.timeZone = TimeZone(secondsFromGMT: 9)
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        let isoDateString = isoFormatter.string(from: now)
        return isoDateString
    }
}
