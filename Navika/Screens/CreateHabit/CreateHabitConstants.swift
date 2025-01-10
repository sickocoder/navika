//
//  CreateHabitConstants.swift
//  Navika
//
//  Created by A255085 on 07/08/24.
//

import SwiftUI

class CreateHabitConstants {
	static let createHabitAvailableSteps: [CreateHabitSteps] = [.chooseCategory, .setFrequency]
	
	static let categoriesList: [HabitCategoryItem] = [
		.init(icon: "drop.fill", color: .blue, title: "Hydrate", description: "Everyday counts"),
		.init(icon: "flame.fill", color: .red, title: "Burn Calories", description: "Everyday counts"),
		.init(icon: "figure.climbing", color: .purple, title: "Climb Flights", description: "Everyday counts"),
		.init(icon: "book.fill", color: .brown, title: "Read", description: "Everyday counts"),
	]
	
	static let bodyCategories: [HabitCategoryItem] = [
		.init(icon: "figure.run", color: .green, title: "Exercise", description: "Everyday counts"),
		.init(icon: "figure.run", color: .pink, title: "Run", description: "Everyday counts"),
		.init(icon: "bed.double.fill", color: .indigo, title: "Sleep", description: "Everyday counts"),
		.init(icon: "figure.stand", color: .gray, title: "Stand Hours", description: "Everyday counts"),
		.init(icon: "figure.walk", color: .gray, title: "Walk", description: "Everyday counts"),
	]
	
	static let categories: [CategoryList] = [
		CategoryList(
			categoryTitle: "Recomended",
			categoryItems: categoriesList
		),
		CategoryList(
			categoryTitle: "Body",
			categoryItems: bodyCategories
		)
	]
	
	static let customHabitCategoryData = HabitCategoryItem(
		icon: "plus",
		color: .accentColor,
		title: "Create Custom",
		description: "Can't find you're desired habit? No worries, just create one"
	)
}
