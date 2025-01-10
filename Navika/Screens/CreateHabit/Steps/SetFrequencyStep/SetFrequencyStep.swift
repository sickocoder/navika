//
//  SetFrequencyStep.swift
//  Navika
//
//  Created by A255085 on 09/08/24.
//

import SwiftUI

struct SetFrequencyStep: View {
  var habitModel: HabitModel? = nil
	@EnvironmentObject var habitSettings: HabitSettings
	
	@State var shouldShowRepeatitionPicker: Bool = false
	@State var shouldShowReminderPicker: Bool = false
	
	@State var description: String = ""
	@State var repetitionDays: Set<Int> = []
	
	@State private var startDate = Date()
	@State private var reminders: [Date] = []
	
	
	var body: some View {
		ScrollView(.vertical) {
			VStack(alignment: .leading, spacing: 20) {
				HeaderView()
					.padding(.bottom, 40)
				
        NATextField(title: "Description", value: $habitSettings.description)
				
				NAFormContainer {
					NADatePicker(
						title: "From",
            value: $habitSettings.startDate,
						range: Date.nextDayDate()...
					)
          
          NADatePicker(
            title: "To",
            value: $habitSettings.endDate,
            range: Date.nextDayDate()...
          )
					
					RepeatFieldView()
				}
				
				NACustomButton(title: "Set a reminder") {
					self.shouldShowReminderPicker.toggle()
				}
				.background(.navikaBlack.opacity(0.03))
				.clipShape(.rect(cornerRadius: 12))
				
				if self.reminders.count > 0 {
					NAFormContainer {
						RemindersList(reminders: $reminders)
					}
				}
				
				Spacer()
			}
			.padding(.top, 30)
			.padding(.horizontal)
		}
		.scrollContentBackground(.hidden)
		.scrollDismissesKeyboard(.interactively)
		.sheet(isPresented: $shouldShowRepeatitionPicker, content: {
			SetFrequencyStepSheet(selection: $repetitionDays)
				.presentationDetents([.medium])
		})
		.sheet(isPresented: $shouldShowReminderPicker, content: {
			SetFrequencyStepReminderSheet { time in
				reminders.append(time)
			}
			.presentationDetents([.medium])
		})
		.onChange(of: repetitionDays) { oldValue, newValue in
			self.habitSettings.reminderWeekDay = Array(repetitionDays)
		}
    .onAppear {
      if let habitModel = habitModel {
        habitSettings.makeConfig(from: habitModel)
      }
    }
	}
}

#Preview {
	SetFrequencyStep()
		.environmentObject(HabitSettings())
}





