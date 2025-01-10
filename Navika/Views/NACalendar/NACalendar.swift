//
//  NACalendar.swift
//  Navika
//
//  Created by A255085 on 02/09/24.
//

import SwiftUI

struct NACalendar: View {
  @Binding var selectedDate: Date
  
  let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
  let columns = Array(repeating: GridItem(.flexible()), count: 7)
  
  @State private var currentMonth: Int = 0
  
  var body: some View {
    VStack(spacing: 24) {
      HStack {
        VStack(alignment: .leading) {
          Text("\(getMonth()[1])")
            .font(.caption)
            .fontWeight(.semibold)
          
          Text("\(getMonth()[0])")
            .font(.title.bold())
        }
        
        Spacer(minLength: 0)
        
        Group {
          Button("", systemImage: "chevron.left") {
            withAnimation {
              currentMonth -= 1
            }
          }
          
          Button("", systemImage: "chevron.right") {
            withAnimation {
              currentMonth += 1
            }
          }
        }
        .bold()
      }
      .padding(.horizontal)
      
      HStack(spacing: 0) {
        ForEach(days, id: \.self) { day in
          Text(day)
            .font(.callout)
            .frame(maxWidth: .infinity)
        }
      }
      
      LazyVGrid(columns: columns, spacing: 10) {
        ForEach(extractDate()) { dateValue in
          DatePill(dateValue)
        }
      }
    }
    .padding(.horizontal, 6)
  }
  
  @ViewBuilder func DatePill(_ dateValue: DateValue) -> some View {
    let foregroundColor: Color = dateValue.date.isEqual(to: selectedDate) ? .white : .navikaBlack
    var backgroundColor: Color {
      if dateValue.date.isEqual(to: selectedDate) {
        return .accent
      }
      
      if dateValue.date.isDateToday() {
        return .navikaBlack.opacity(0.1)
      }
      
      return .clear
    }
    
    VStack {
      if dateValue.day > 0 {
        Text("\(dateValue.day)")
          .font(.title3.bold())
          .frame(maxWidth: .infinity)
          .padding(.vertical, 10)
          .foregroundStyle(foregroundColor)
          .background(backgroundColor)
          .clipShape(.circle)
          .onTapGesture {
            withAnimation {
              selectedDate = dateValue.date
            }
          }
      }
    }
  }
  
  func getMonth() -> [String] {
    let calendar = Calendar.current
    
    guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else { return [] }
    
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM YYYY"
    
    let date = formatter.string(from: currentMonth)
    
    return date.components(separatedBy: " ")
  }
  
  func extractDate() -> [DateValue] {
    let calendar = Calendar.current
    guard let currentMonth = calendar.date(byAdding: .month, value: currentMonth, to: Date()) else { return [] }
    
    var days = currentMonth.getAllDates().compactMap { date -> DateValue in
      let day = calendar.component(.day, from: date)
      return DateValue(day: day, date: date)
    }
    
    let firstWeekDay = calendar.component(.weekday, from: days.first?.date ?? Date())
    for _ in 0..<firstWeekDay - 1 {
      days.insert(DateValue(day: -1, date: Date()), at: 0)
    }
    
    return days
  }
}

#Preview {
  NACalendar(selectedDate: .constant(Date()))
}
