//
//  NAInlinePicker.swift
//  Navika
//
//  Created by A255085 on 10/08/24.
//

import SwiftUI


struct NAInlinePicker<T: NAGenericType, Content: View>: View {
	let options: [T]
	@Binding var selectedOption: T
	
	let title: LocalizedStringKey?
	@ViewBuilder let content: (_ option: T) -> Content
	
	var body: some View {
		VStack(alignment: .leading, spacing: 12) {
			if let title = title {
				Text(title)
			}
			
			ForEach(options, id: \.self) { option in
				Button(action: {
					withAnimation {
						self.selectedOption = option
					}
				}, label: {
					HStack {
						content(option)
						Spacer()
						
						if option == selectedOption {
							Image(systemName: "checkmark.circle.fill")
								.resizable()
								.bold()
								.frame(width: 24, height: 24)
						}
					}
					.padding(.horizontal, 8)
					.padding(.vertical, 8)
				})
				.buttonStyle(.borderedProminent)
				.tint(.navikaBlack)
				.opacity(option == selectedOption ? 0.8 : 0.4)
			}
		}
	}
}


#Preview {
	NAInlinePicker(
		options: TimeOfDay.allCases,
		selectedOption: .constant(.morning),
		title: "Which time of the day suits you better?"
	) { option in
		Text(option.rawValue)
			.font(.title3)
	}
	.padding()
}
