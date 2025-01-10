//
//  Date+Extensions.swift
//  Navika
//
//  Created by A255085 on 03/08/24.
//

import Foundation

extension Date {
  static func getCurrentWeekDays() -> [WeekDaysViewDateModel] {
    let calendar = Calendar.current
    let today = calendar.startOfDay(for: Date())
    let dayOfWeek = calendar.component(.weekday, from: today)
    let dates = calendar.range(of: .weekday, in: .weekOfYear, for: today)!
      .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: today) }
    
    let formatter = DateFormatter()
    formatter.dateFormat = "dd eeeee"
    
    return dates.map {
      let date = formatter.string(from: $0).split(separator: " ")
      let weekDate = WeekDaysViewDateModel(
        day: String(date[0]),
        abbreviation: String(date[1]),
        fullDate: $0
      )
      
      return weekDate
    }
  }
  
  static func getCurrentWeekDay(format: String = "dd eeee") -> WeekDaysViewDateModel {
    let todayDate = Date()
    
    let formatter = DateFormatter()
    formatter.dateFormat = format
    
    let date = formatter.string(from: todayDate).split(separator: " ")
    
    let weekDate = WeekDaysViewDateModel(
      day: String(date[0]),
      abbreviation: String(date[1]),
      fullDate: todayDate
    )
    
    return weekDate
  }
  
  func getCurrentWeekDay(format: String = "dd eeee") -> WeekDaysViewDateModel {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    
    let date = formatter.string(from: self).split(separator: " ")
    
    let weekDate = WeekDaysViewDateModel(
      day: String(date[0]),
      abbreviation: String(date[1]),
      fullDate: self
    )
    
    return weekDate
  }
  
  func isDateToday() -> Bool {
    return Calendar.current.isDateInToday(self)
  }
  
  func isGreater(than date: Date) -> Bool {
    return self > date
  }
  
  func isEqual(to date: Date) -> Bool {
    return Calendar.current.isDate(self, inSameDayAs: date)
  }
  
  func getRelativeFormattedString() -> String {
    let relativeDateFormatter = DateFormatter()
    relativeDateFormatter.timeStyle = .none
    relativeDateFormatter.dateStyle = .medium
    relativeDateFormatter.doesRelativeDateFormatting = true
    
    return relativeDateFormatter.string(from: self)
  }
  
  static func getHoursFor(timeofDay: TimeOfDay) -> ClosedRange<Date> {
    let today = Date()
    var sortedTime: [Date] = []
    
    var calender = Calendar(identifier: .iso8601)
    calender.locale = Locale(identifier: "en_US_POSIX")
    
    var range: ClosedRange<Int> = 0...12
    
    switch timeofDay {
    case .morning: range = 0...11
    case .afternoon: range = 12...17
    case .evening: range = 18...23
    }
    
    
    range.forEach {
      guard
        let newDate = calender.date(byAdding: .hour, value: $0, to: calender.startOfDay(for: today)),
        calender.component(.hour, from: newDate) <= 23 else {
        return
      }
      sortedTime.append(newDate)
    }
    
    return sortedTime.first!
    ...
    calender.date(byAdding: .minute, value: 59, to: sortedTime.last!)!
  }
  
  static func nextDayDate() -> Date {
    return Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
  }
  
  func getTimeAsString() -> String {
    let components = Calendar.current.dateComponents([.hour, .minute], from: self)
    
    return "\(components.hour?.padLeft() ?? "-1"):\(components.minute?.padLeft() ?? "-1")"
  }
  
  func getWeekDay() -> Int {
    let weekday = Calendar.current.component(.weekday, from: self)
    return weekday
  }
  
  func getAllDates() -> [Date] {
    let calendar = Calendar.current
    
    let startDate = calendar.date(from: Calendar.current.dateComponents([.month, .year], from: self))!
    let range = calendar.range(of: .day, in: .month, for: startDate)!
    
    return range.compactMap { day -> Date in
      return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
    }
  }

  
  func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
    return calendar.dateComponents(Set(components), from: self)
  }
  
  func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
    return calendar.component(component, from: self)
  }
  
}

