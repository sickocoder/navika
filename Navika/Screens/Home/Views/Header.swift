//
//  NAHeader.swift
//  Navika
//
//  Created by A255085 on 05/08/24.
//

import SwiftUI

struct Header: View {
  private let daysOfCurrentWeek: [WeekDaysViewDateModel] = Date.getCurrentWeekDays()
  private let middleOfWeek: WeekDaysViewDateModel = Date.getCurrentWeekDays()[2]
  
  @State private var selectedWeekDay: Date = Date()
  @State var isFullCalendarShown: Bool = false
  @State var weekListVisible: Bool = true
  
  let scrollProgress: CGFloat
  let onWeekDayPress: (_ weekDay: WeekDaysViewDateModel) -> ()
  let onCreateHabitPress: () -> ()
  let onViewCalendarPress: () -> ()
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        if weekListVisible {
          Text("Hi, Jose!")
            .font(.title)
            .bold()
        }
        
        Spacer()
        
        Group {
          Button("", systemImage: "calendar") {
            withAnimation {
              isFullCalendarShown.toggle()
              weekListVisible.toggle()
            } completion: {
              onViewCalendarPress()
            }
          }
          
          Button("", systemImage: "plus", action: onCreateHabitPress)
        }
        .bold()
        .font(.title2)
        .foregroundStyle(.navikaBlack)
      }
      .frame(height: 40 - (40 * scrollProgress), alignment: .bottom)
      .padding(.horizontal)
      .padding(.top, 15)
      .padding(.bottom, 15 - (15 * scrollProgress))
      .opacity(1 - scrollProgress)
      .offset(y: -10 * scrollProgress)
      
      if isFullCalendarShown {
        NACalendar(selectedDate: $selectedWeekDay)
      }
     
      if weekListVisible {
        ScrollViewReader { proxy in
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
              ForEach(daysOfCurrentWeek) { weekDay in
                WeekDayPill(
                  day: weekDay,
                  isSelected: weekDay.day == selectedWeekDay.getCurrentWeekDay().day
                )
                .onTapGesture {
                  withAnimation {
                    self.selectedWeekDay = weekDay.fullDate
                  } completion: {
                    self.onWeekDayPress(weekDay)
                  }
                }
                .id(weekDay.day)
              }
            }
            .padding(.horizontal)

          }
          .onAppear(perform: {
            
            withAnimation {
              proxy.scrollTo(
                selectedWeekDay.getCurrentWeekDay().day,
                anchor: .center
              )
            }
          })
        }
      }
      
    }
    
  }
}

#Preview {
  Header(scrollProgress: 0) { weekDay in
    
  } onCreateHabitPress: {
    
  } onViewCalendarPress: {
    
  }
  
}



