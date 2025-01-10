//
//  NAHorizontalPicker.swift
//  Navika
//
//  Created by A255085 on 09/08/24.
//
import SwiftUI

struct NAHorizontalPicker<T: NAGenericType, Content: View>: View {
	let options: [T]
	@Binding var selectedOptions: [T]
	
	let title: LocalizedStringKey?
	@ViewBuilder let content: (_ option: T) -> Content
	
	var body: some View {
		VStack(alignment: .leading, spacing: 12) {
			if let title = title {
				Text(title)
					.padding(.leading)
			}
			
			ScrollView(.horizontal, showsIndicators: false) {
				HStack(spacing: 6) {
					ForEach(options, id: \.self) { option in
						Button(action: {
							withAnimation {
								if self.selectedOptions.contains(option) {
									self.selectedOptions.removeAll { currentOption in
										currentOption == option
									}
								} else {
									self.selectedOptions.append(option)
								}
							}
						}, label: {
							self.content(option)
						})
						.clipShape(.circle)
						.tint(.navikaBlack)
						.buttonStyle(.borderedProminent)
						.opacity(selectedOptions.contains(option) ? 1 : 0.5)
					}
				}
			}
			.contentMargins(.leading, 20, for: .scrollContent)
		}
	}
}

#Preview {
	NAHorizontalPicker(
		options: DaysOfWeak.allCases,
		selectedOptions: .constant([.sunday]),
		title: "Which time of the day suits you better?"
	) { option in
		Text(option.rawValue.first?.uppercased() ?? "")
			.font(.body)
			.fontWeight(.semibold)
			.padding(6)
	}
}

