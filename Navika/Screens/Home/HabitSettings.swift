//
//  HabitSettings.swift
//  Navika
//
//  Created by A255085 on 27/08/24.
//

import SwiftUI

class HabitSettings: ObservableObject {
  @Published var habitList: [HabitModel] = []
  
  @Published var description: String = ""
	@Published var weekDay: WeekDaysViewDateModel = Date.getCurrentWeekDay()
	@Published var category: HabitCategoryItem?
	
	@Published var startDate = Date()
  @Published var endDate = Date()
  
	@Published var reminderWeekDay: [Int] = []
  
  @Published var tasks: [HabitTask] = []
	
	@Published var userGrantedPermissionForNotification: Bool = false
	
	var frequency: HabitFrequencyModel {
		.init(
			startDate: startDate,
			reminders: self.setReminders(for: reminderWeekDay)
		)
	}
	
	func requestPermissionForNotification() {
		UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
			self.userGrantedPermissionForNotification = success
			if success {
				print("Permission approved!")
			} else if let error = error {
				print(error.localizedDescription)
			}
		}
	}
	
	func setReminders(for weekDays: [Int]) -> [NAReminder] {
		let reminders: [NAReminder] = weekDays.map { setSingleReminder(for: $0) }
		return reminders
	}
	
	func setSingleReminder(for weekDay: Int) -> NAReminder {
		let content = UNMutableNotificationContent()
		content.title = "Notification title."
		content.subtitle = "Notification content."
		content.sound = UNNotificationSound.default
		
		let trigger = UNCalendarNotificationTrigger(dateMatching: .init(weekday: weekDay), repeats: true)
		
		let notificationIdentifier = UUID().uuidString
		let request = UNNotificationRequest(
			identifier: notificationIdentifier,
			content: content,
			trigger: trigger
		)
		
		UNUserNotificationCenter.current().add(request)
		
		return .init(id: notificationIdentifier, weekDay: weekDay)
	}
	
	func removeAllReminders(withIdentifiers identifiers: [String]) {
		UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: identifiers)
	}
	
	func makeHabitModel() -> HabitModel? {
		guard let category = self.category
		else { return nil }
		
		let frequency: HabitFrequencyModel = .init(
			startDate: startDate,
			reminders: self.setReminders(for: reminderWeekDay)
		)
		
    return .init(description: self.description ,weekDay: self.weekDay, category: category, frequency: frequency)
	}
  
  func makeConfig(from habitModel: HabitModel) {
    self.category = habitModel.category
    self.startDate = habitModel.frequency.startDate
//    self.reminderWeekDay = habitModel.frequency.reminders.map(\.0)
    self.reminderWeekDay = []
    self.description = habitModel.description
    self.weekDay = habitModel.weekDay
    self.tasks = [] /// MARK: - TODO change later
  }
	
}

