//
//  TimeOfDaysTabs.swift
//  Navika
//
//  Created by A255085 on 13/08/24.
//

import SwiftUI

struct TimeOfDaysTabs: View {
	@Binding var selectedTimeOfDay: TimeOfDay
	
    var body: some View {
			HStack {
				ForEach(HomeScreenConstants.timesOfDay, id: \.self) { timeOfDay in
					Button {
						withAnimation {
							self.selectedTimeOfDay = timeOfDay
						}
					} label: {
						Text("\(timeOfDay.rawValue)")
							.fontWeight(.semibold)
							.padding(.vertical, 2)
							.padding(.horizontal, 10)
					}
					.buttonStyle(BorderedProminentButtonStyle())
					.clipShape(.capsule)
					.tint(selectedTimeOfDay.isEqual(to: timeOfDay)  ? .accent : Color.navikaBlack.opacity(0.3))
				}
			}
    }
}

#Preview {
	TimeOfDaysTabs(selectedTimeOfDay: .constant(.evening))
}
