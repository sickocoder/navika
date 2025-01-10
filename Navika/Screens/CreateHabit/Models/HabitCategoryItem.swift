//
//  HabitCategoryItem.swift
//  Navika
//
//  Created by A255085 on 07/08/24.
//
import SwiftUI

import SwiftUI

struct HabitCategoryItem: Identifiable, Codable, Hashable {
	let id: String
	
	let icon: String
	let colorHex: String // Use a hex string to represent color
	let title: String
	let description: String
	var isFavourite: Bool = false
	
	// Computed property to convert hex to Color
	var color: Color {
		Color(hex: colorHex)
	}
	
	// Custom initializer to allow usage of Color directly
	init(id: String = UUID().uuidString, icon: String, color: Color, title: String, description: String, isFavourite: Bool = false) {
		self.id = id
		self.icon = icon
		self.colorHex = color.toHexString() // Convert Color to hex string
		self.title = title
		self.description = description
		self.isFavourite = isFavourite
	}
	
	// Custom decoding initializer
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		id = try container.decode(String.self, forKey: .id)
		icon = try container.decode(String.self, forKey: .icon)
		
		colorHex = try container.decode(String.self, forKey: .colorHex)
		
		title = try container.decode(String.self, forKey: .title)
		description = try container.decode(String.self, forKey: .description)
		isFavourite = try container.decodeIfPresent(Bool.self, forKey: .isFavourite) ?? false
	}
	
	// Keys used for decoding
	enum CodingKeys: String, CodingKey {
		case id, icon, colorHex, title, description, isFavourite
	}
}

