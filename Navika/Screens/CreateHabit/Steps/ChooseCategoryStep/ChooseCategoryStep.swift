//
//  ChooseCategoryStep.swift
//  Navika
//
//  Created by A255085 on 09/08/24.
//

import SwiftUI

struct ChooseCategoryStep: View {
	@EnvironmentObject var habitSettings: HabitSettings
	
	@State var searchText: String = ""
	let categories = CreateHabitConstants.categories
	
	let onCategorySelected: (_ category: HabitCategoryItem) -> ()
	
	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			NASlideView(edge: .bottom) {
				VStack {
					if !isSearching {
						CategoryItem(category: CreateHabitConstants.customHabitCategoryData)
							.padding(.bottom)
					}
					
					ForEach(searchedHabits) { category in
						VStack {
							Section {
								CategorySectionView(categories: category.categoryItems)
							} header: {
								HStack {
									Text(category.categoryTitle)
										.font(.headline)
										.bold()
									
									Spacer()
								}
								.padding(.horizontal, 10)
							}
						}
						.padding(.bottom)
					}
				}
			}
		}
		.listStyle(.plain)
		.contentMargins(20, for: .scrollContent)
		.navigationTitle("Create Habit")
		.navigationBarTitleDisplayMode(.inline)
		.searchable(text: $searchText, prompt: Text("Search for a habit..."))
		.autocorrectionDisabled()
		.overlay {
			if searchedHabits.isEmpty && !searchText.isEmpty {
				ContentUnavailableView.search
					.frame(width: UIScreen.main.bounds.width)
			}
		}
	}
}

#Preview {
	ChooseCategoryStep { category in }
		.environmentObject(HabitSettings())
}

