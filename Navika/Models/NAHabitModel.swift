//
//  NAHabit.swift
//  Navika
//
//  Created by A255085 on 26/08/24.
//

import Foundation
import FirebaseFirestore

struct NATaskModel: FirestoreModel {
  var id = UUID().uuidString
	
	var title: String
	var description: String = ""
  var actionsDays: [String]
  var endsAt: Timestamp
  var habitId: String
  
  var isSelected: Bool = false
}

struct NAReminder: Identifiable, Hashable {
	let id: String
	let weekDay: Int
}

extension NAReminder: Codable {
	enum CodingKeys: String, CodingKey {
		case id
		case weekDay
	}
}

struct NAHabitModel: Identifiable {
	let id = UUID().uuidString
	
	let description: String
	
	let category: HabitCategoryItem
  let tasks: [DocumentReference]
	let from: WeekDaysViewDateModel
  let to: WeekDaysViewDateModel
	
	let reminders: [NAReminder]
}

extension HabitModel {
  func isForToday() -> Bool {
    self.frequency.reminders.contains { $0.weekDay == Int(Date().getCurrentWeekDay().day) }
  }
}
