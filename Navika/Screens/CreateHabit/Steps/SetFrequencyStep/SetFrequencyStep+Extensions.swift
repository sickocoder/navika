//
//  SetFrequencyStep+Extensions.swift
//  Navika
//
//  Created by A255085 on 10/08/24.
//

import SwiftUI

extension SetFrequencyStep {
  @ViewBuilder func SelectedHabitCategory(category: HabitCategoryItem) -> some View {
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
	
	@ViewBuilder func HeaderView() -> some View {
		VStack(alignment: .leading) {
			Text("Define a frequency for the habit")
				.bold()
      
      if let category = habitSettings.category {
        SelectedHabitCategory(category: category)
      }
		}
		.padding()
		.overlay {
			RoundedRectangle(cornerRadius: 12)
				.strokeBorder(
					.navikaBlack.opacity(0.5),
					style: StrokeStyle(lineWidth: 3, dash: [10])
				)
		}
	}
	
	@ViewBuilder func RepeatFieldView() ->  some View {
		HStack {
			Text("Repeats")
				.opacity(0.27)
			
			Spacer()
			
			HStack {
				Text("\(repetitionDays.getReadableDays())")
				Image(systemName: "chevron.up.chevron.down")
					.font(.caption)
			}
			.onTapGesture {
				shouldShowRepeatitionPicker.toggle()
			}
		}
		.padding(.horizontal)
		.padding(.bottom)
	}
}
