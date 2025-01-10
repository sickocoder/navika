//
//  HabitFrequencyModel.swift
//  Navika
//
//  Created by A255085 on 14/08/24.
//

import Foundation

typealias ReminderTime = Date

struct HabitFrequencyModel: Hashable {
	let startDate: Date
	let reminders: [NAReminder]
}

extension HabitFrequencyModel: Codable {
	enum CodingKeys: String, CodingKey {
		case startDate
		case reminders
	}
}
