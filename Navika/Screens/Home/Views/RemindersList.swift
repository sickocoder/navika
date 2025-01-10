//
//  RemindersList.swift
//  Navika
//
//  Created by A255085 on 12/08/24.
//

import SwiftUI

struct ReminderRow: View {
	let data: Date
	
	var body: some View {
		HStack(alignment: .top, spacing: 20) {
			Image(systemName: "bell")
				.font(.title2)
				.padding(.top, 4)
			
			VStack(alignment: .leading) {
				Text(data.getTimeAsString())
				Text("Morning")
					.font(.caption)
				Spacer()
			}
		}
		.listRowInsets(EdgeInsets())
		.listRowBackground(Color.clear)
		.padding(.horizontal)
		.padding(.vertical, 10)
	}
}

struct RemindersList: View {
	@Binding var reminders: [Date]
	
	var body: some View {
		List {
			ForEach(self.reminders, id: \.self) { reminder in
				ReminderRow(data: reminder)
			}
			.onDelete{ indexSet in
				if !indexSet.isEmpty {
					withAnimation {
						self.reminders.remove(atOffsets: indexSet)
					}
				}
			}
		}
		.listStyle(.plain)
		.scrollContentBackground(.hidden)
		.scrollDisabled(true)
		.frame(maxWidth: .infinity)
		.frame(minHeight: 64 * CGFloat(reminders.count))
	}
}
