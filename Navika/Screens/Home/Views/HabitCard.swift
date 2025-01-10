//
//  HabitCard.swift
//  Navika
//
//  Created by A255085 on 22/08/24.
//

import SwiftUI

struct HabitCard: View {
	let habit: HabitModel
	
	var habitCategory: HabitCategoryItem {
		habit.category
	}
	
	@State var currentAmount = 0.0
	@State var finalAmount = 1.0
	
	var body: some View {
		VStack {
			HStack(alignment: .top, spacing: 16) {
				Image(systemName: habitCategory.icon)
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 18, height: 18)
					.foregroundColor(habitCategory.color)
					.padding()
					.overlay {
						NACircularProgressView(
							color: habitCategory.color,
							lineWidth: 8,
							progress: .constant(0.5)
						)
					}
				
				VStack(alignment: .leading) {
					Text("\(habitCategory.title)")
						.fontWeight(.semibold)
					
					Text("everyday • 4 tasks")
						.font(.callout)
						.opacity(0.7)
						.padding(.bottom)
				}
				
				Spacer()
			}
		}
		.padding()
		.background(Color.navikaBlack.opacity(0.03))
		.contextMenu(menuItems: {
			Label("Edit habit", systemImage: "pencil")
				.fontWeight(.semibold)
			
			Label("Mark as done", systemImage: "checkmark")
				.fontWeight(.semibold)
		}, preview: {
			VStack(alignment: .leading) {
				HStack(spacing: 12) {
					Image(systemName: habitCategory.icon)
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 20, height: 20)
						.foregroundColor(habitCategory.color)
					
					VStack(alignment: .leading) {
						Text("\(habitCategory.title)")
							.bold()
						
						Text("4 Related Tasks")
							.font(.caption)
					}
				}
				
				Divider()
				
				VStack(alignment: .leading, spacing: 16) {
					Text("Do 50 push-ups")
						.strikethrough()
					
					Text("Run 10 miles a day")
					Text("Bench 40kg")
					Text("Drink a lot a water")
				}
				.padding(.top, 12)
			}
			.padding()
			.frame(width: UIScreen.main.bounds.width, alignment: .leading)
		})
		.clipShape(.rect(cornerRadius: 30))
        .padding(.horizontal)
        .padding(.top)
	}
}


//#Preview {
//	HabitCard(habit: CreateHabitConstants.bodyCategories[0])
//}
