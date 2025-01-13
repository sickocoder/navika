//
//  SetFrequencyStep.swift
//  Navika
//
//  Created by A255085 on 09/08/24.
//

import SwiftUI

struct SetFrequencyStep: View {
  @EnvironmentObject var habitSettings: HabitSettings
  @StateObject var viewModel =  SetFrequencyViewModel()
  
  var habitModel: HabitModel? = nil
  var isEditing: Bool {
    self.habitModel != nil
  }
  
	
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
          self.viewModel.shouldShowReminderPicker.toggle()
				}
				.background(.navikaBlack.opacity(0.03))
				.clipShape(.rect(cornerRadius: 12))
				
        if self.viewModel.reminders.count > 0 {
					NAFormContainer {
            RemindersList(reminders: $viewModel.reminders)
					}
				}
				
				Spacer()
			}
			.padding(.top, 30)
			.padding(.horizontal)
		}
		.scrollContentBackground(.hidden)
		.scrollDismissesKeyboard(.interactively)
    .toolbar {
      if self.isEditing {
        HStack(spacing: 16) {
          Button("delete") {}
            .tint(.red)
          
          Button("Save") {
            Task {
              if let habitModel = self.habitModel, let newHabitModel = self.habitSettings.makeHabitModel() {
                do {
                  try await FirestoreHelper.shared.update(document: habitModel.id, onCollection: .habits, withData: newHabitModel)
                }
              }
            }
          }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
        }
      }
    }
    .sheet(isPresented: $viewModel.shouldShowRepeatitionPicker, content: {
      SetFrequencyStepSheet(selection: $viewModel.repetitionDays)
				.presentationDetents([.medium])
		})
    .sheet(isPresented: $viewModel.shouldShowReminderPicker, content: {
			SetFrequencyStepReminderSheet { time in
        viewModel.reminders.append(time)
			}
			.presentationDetents([.medium])
		})
    .onChange(of: viewModel.repetitionDays) { oldValue, newValue in
      self.habitSettings.reminderWeekDay = Array(viewModel.repetitionDays)
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





