//
//  WeekDayPill.swift
//  Navika
//
//  Created by A255085 on 03/08/24.
//

import SwiftUI

struct WeekDayPill: View {
	var day: WeekDaysViewDateModel
	var isSelected: Bool
  
  func getPillBackgroundColor() -> Color {
    if isSelected { return .accent }
    if Date().isEqual(to: day.fullDate) { return .navikaBlack.opacity(0.2) }
    
    return .clear
  }
	
	var body: some View {
		VStack {
			Text(day.abbreviation)
				.font(.caption)
				.bold()
				.foregroundStyle(isSelected ? .white : .navikaBlack)
				.padding(.top, 6)
				.padding(.bottom, 6)
			
			Text(day.day)
				.font(.title2)
				.bold()
				.padding(10)
				.background(.white)
				.clipShape(.circle)
			
		}
		.padding(4)
    .background(self.getPillBackgroundColor())
		.clipShape(.capsule)
	}
}

#Preview {
	WeekDayPill(day: .init(day: "2", abbreviation: "S", fullDate: Date()), isSelected: false)
}

