//
//  SetFrequencyStepReminderSheet.swift
//  Navika
//
//  Created by A255085 on 12/08/24.
//

import SwiftUI
import UserNotifications

struct SetFrequencyStepReminderSheet: View {
	@AppStorage("isNotificationPermissionGranted") var isNotificationPermissionGranted: Bool = false
	
	@Environment(\.dismiss) var dismiss
	@State private var reminderTime = Date()
	
	let onTimeSelected: (_ time: Date) -> ()
	
	var body: some View {
		VStack(alignment: .center, spacing: 20) {
			Text("Let us know the perfect time for us to remind you 😉")
				.multilineTextAlignment(.center)
			
			DatePicker(
				selection: $reminderTime,
				displayedComponents: [.hourAndMinute]
			) {}
				.datePickerStyle(.wheel)
				.labelsHidden()
			
			Spacer()
			
			NAPrimaryButon(title: "Save Reminder") {
				if self.isNotificationPermissionGranted {
					Task {
						await self.scheduleLocal(for: reminderTime)
						self.onTimeSelected(reminderTime)
					}
					
				} else {
					self.requestLocal()
				}
				
				self.dismiss()
			}
		}
		.padding()
    .onAppear {
      self.requestLocal()
    }
	}
	
	func requestLocal() {
		let center = UNUserNotificationCenter.current()
		
		center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
			self.isNotificationPermissionGranted = granted
			
			if granted {
				print("Permission granted")
			} else {
				print("Permission denied")
			}
		}
	}
	
	func scheduleLocal(for date: Date) async {
		let content = UNMutableNotificationContent()
		
		content.title = "This is a test notification"
		content.body = "This should be the body of the notification"
		
		var dateComponents = DateComponents()
		dateComponents.calendar = Calendar.current
		
		dateComponents.weekday = 3 // tuesday
		dateComponents.hour = 11
		dateComponents.minute = 15
		
		let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
		
		let uuidString = UUID().uuidString
		let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
		
		let notificationCenter = UNUserNotificationCenter.current()
		do {
			try await notificationCenter.add(request)
		} catch {
			print(error)
		}

	}
}
