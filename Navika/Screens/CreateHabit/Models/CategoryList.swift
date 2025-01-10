//
//  CategoryList.swift
//  Navika
//
//  Created by A255085 on 07/08/24.
//
import Foundation

struct CategoryList: Identifiable {
	let id = UUID().uuidString
	let categoryTitle: String
	
	let categoryItems: [HabitCategoryItem]
}
