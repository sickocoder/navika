//
//  HomeScreenViewModel.swift
//  Navika
//
//  Created by A255085 on 14/08/24.
//

import Foundation
import FirebaseFirestore

struct HabitModel: FirestoreModel, Hashable {
	var id: String = UUID().uuidString
  
  let description: String
	
	let weekDay: WeekDaysViewDateModel
	let category: HabitCategoryItem
	let frequency: HabitFrequencyModel
  
  var tasks: [DocumentReference] = []
}

struct HabitTask: FirestoreModel, Hashable {
  var id: String = UUID().uuidString
  
  var title: String
  var description: String = ""
  var isSelected: Bool = false
}
