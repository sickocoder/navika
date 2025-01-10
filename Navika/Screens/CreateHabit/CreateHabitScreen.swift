//
//  CreateHabitScreen.swift
//  Navika
//
//  Created by A255085 on 06/08/24.
//

import SwiftUI

struct CreateHabitScreen: View {
  @EnvironmentObject var habitSettings: HabitSettings
  
	private let paginationLimit: Int = CreateHabitConstants.createHabitAvailableSteps.count - 1
	
	@State private var currentStepIndex: Int = 0
	@State private var selectedCategory: HabitCategoryItem?
	
	var body: some View {
		TabView(selection: $currentStepIndex) {
			ChooseCategoryStep { category in
				self.selectedCategory = category
				currentStepIndex.incrementUntil(limit: paginationLimit)
			}
			.gesture(DragGesture())
			.tag(0)
			
      if habitSettings.category != nil {
				NAStepView(currentPage: $currentStepIndex) {
					SetFrequencyStep()
				}
				.navigationTitle("Set a frequency")
				.gesture(DragGesture())
				.tag(1)
			}
		}
		.tabViewStyle(.page(indexDisplayMode: .never))
	}
}

#Preview {
	CreateHabitScreen()
		.environmentObject(HabitSettings())
}



