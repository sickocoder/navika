//
//  WeekDaysViewDateModel.swift
//  Navika
//
//  Created by A255085 on 03/08/24.
//

import Foundation

struct WeekDaysViewDateModel: Identifiable, Hashable {
	var id = UUID().uuidString
	let day: String
	let abbreviation: String
	
	let fullDate: Date
}

extension WeekDaysViewDateModel: Codable {
	enum CodingKeys: String, CodingKey {
		case id
		case day
		case abbreviation
		case fullDate
	}
}
