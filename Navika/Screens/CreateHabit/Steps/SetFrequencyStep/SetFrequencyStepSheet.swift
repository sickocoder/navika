//
//  SetFrequencyStepSheet.swift
//  Navika
//
//  Created by A255085 on 09/08/24.
//

import SwiftUI

struct SetFrequencyStepSheet: View {
	@Environment(\.dismiss) var dismiss
	@Binding var selection: Set<Int>
	
	var body: some View {
		VStack {
			HStack {
				Text("Select the frequency")
				Spacer()
				Button("Done") {
					self.dismiss()
				}
				.bold()
			}
			.padding()
			.background(Color.navikaBlack.opacity(0.03))
			
      List(GlobalConstants.daysOfWeek.indices, id: \.self) { dayIndex in
				HStack {
					if self.selection.contains(dayIndex) {
						Image(systemName: "checkmark")
					}
					Text("\(GlobalConstants.daysOfWeek[dayIndex])")
					Spacer()
				}
				.padding(10)
				.bold(self.selection.contains(dayIndex))
				.onTapGesture {
					withAnimation {
						if self.selection.contains(dayIndex) {
							self.selection.remove(dayIndex)
						} else {
							self.selection.insert(dayIndex)
						}
					}
				}
			}
			.listStyle(.plain)
		}
	}
}
