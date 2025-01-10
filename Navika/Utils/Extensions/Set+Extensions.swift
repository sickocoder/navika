//
//  Set+Extensions.swift
//  Navika
//
//  Created by A255085 on 09/08/24.
//

import Foundation

let MAXIMUM_DAYS_IN_A_WEEK = 7
let MINIMUM_DAYS_IN_A_WEEK = 1

extension Set where Set.Element == Int {
	func getReadableDays() -> String {
		if self.count == MAXIMUM_DAYS_IN_A_WEEK {
			return "Daily"
		}
		
		if self.count == MINIMUM_DAYS_IN_A_WEEK {
			return "Every \(GlobalConstants.daysOfWeek[self.first!].lowercased())"
		}
		
		var result = ""
		self.forEach { weekDay in
			result += GlobalConstants.daysOfWeek[weekDay].prefix(3) + ","
		}
		
		return String(result.dropLast().lowercased())
	}
}
