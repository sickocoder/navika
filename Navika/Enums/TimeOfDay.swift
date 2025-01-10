//
//  TimeOfDay.swift
//  Navika
//
//  Created by A255085 on 03/08/24.
//

import Foundation

enum TimeOfDay: String, NAGenericType, CaseIterable {
	case morning = "Morning"
	case afternoon = "Afternoon"
	case evening = "Evening"
	
	func isEqual(to time: TimeOfDay) -> Bool {
		return self == time
	}
}
