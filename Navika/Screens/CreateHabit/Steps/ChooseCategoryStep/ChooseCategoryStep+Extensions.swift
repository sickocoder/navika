//
//  ChooseCategoryStep+Extensions.swift
//  Navika
//
//  Created by A255085 on 09/08/24.
//

import SwiftUI

extension ChooseCategoryStep {
	var isSearching: Bool {
		!searchText.isEmpty
	}
	
	var searchedHabits: [CategoryList] {
		if searchText.isEmpty { return categories }
		
		return categories.reduce([]) { partialResult, categoryList in
			let categoryItems = categoryList.categoryItems.filter { item in
				item.title.contains(searchText)
			}
			
			if categoryItems.count > 0 {
				return partialResult + [CategoryList(
					categoryTitle: categoryList.categoryTitle,
					categoryItems: categoryItems
				)]
			}
			
			return partialResult
		}
	}
	
	@ViewBuilder func CategoryItem(category: HabitCategoryItem) -> some View {
		HStack(alignment: .center, spacing: 12) {
			Image(systemName: category.icon)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 18, height: 18)
				.foregroundStyle(Color.white)
				.padding(5)
				.background(Circle().fill(category.color))
				.padding(6)
				.background(Circle().stroke(category.color.secondary, lineWidth: 5))
			
			VStack(alignment: .leading) {
				Text("\(category.title)")
					.fontWeight(.semibold)
				
				Text("\(category.description)")
					.font(.callout)
					.opacity(0.7)
			}
			.foregroundStyle(Color.navikaBlack)
			
			Spacer()
		}
		.padding(.all, 14)
		.background(Color.navikaBlack.opacity(0.03))
		.clipShape(.rect(cornerRadius: 12))
	}
	
	@ViewBuilder func CategorySectionView(categories: [HabitCategoryItem]) -> some View {
		ForEach(categories) { category in
			CategoryItem(category: category)
				.onTapGesture {
					self.habitSettings.category = category
					onCategorySelected(category)
				}
		}
	}
}

