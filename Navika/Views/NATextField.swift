//
//  NATextView.swift
//  Navika
//
//  Created by A255085 on 09/08/24.
//

import SwiftUI

struct NATextField: View {
	var title: LocalizedStringKey
	@Binding var value: String
	var keyboardType: UIKeyboardType = .default
	
	@FocusState private var isFocused: Bool
	
	
	var body: some View {
		TextField(title, text: $value)
			.keyboardType(keyboardType)
			.textFieldStyle(.plain)
			.frame(height: 48)
			.controlSize(.large)
			.padding(.leading, 16)
			.scrollContentBackground(.hidden)
		//			.background(Color.defaultBackground)
			.focused($isFocused)
			.cornerRadius(12) /// make the background rounded
			.overlay( /// apply a rounded border
				RoundedRectangle(cornerRadius: 12)
					.stroke(isFocused ? .accent : .navikaBlack.opacity(0.1), lineWidth: 1.5)
			)
	}
}

struct NADatePicker: View {
	var title: LocalizedStringKey
	@Binding var value: Date
	var range: PartialRangeFrom<Date>? = nil
	
	
	@FocusState private var isFocused: Bool
	
	var body: some View {
		Form {
			HStack {
				Text(title)
					.opacity(0.26)
				
				Spacer()
				if let dateRange = range {
					DatePicker(
						title,
						selection: $value,
						in: dateRange,
						displayedComponents: .date
					)
					.labelsHidden()
					.datePickerStyle(.compact)
					.focused($isFocused)
				} else {
					DatePicker(title, selection: $value, displayedComponents: .date)
						.labelsHidden()
						.datePickerStyle(.compact)
						.focused($isFocused)
				}
			}
			.padding(.trailing, 8)
			.frame(height: 48)
			.controlSize(.large)
			.padding(.leading, 16)
			.scrollContentBackground(.hidden)
			.cornerRadius(12) /// make the background rounded
			.overlay( /// apply a rounded border
				RoundedRectangle(cornerRadius: 12)
					.stroke(.accent.opacity(isFocused ? 1 : 0), lineWidth: 2)
			)
		}
		.scrollContentBackground(.hidden)
		.formStyle(.columns)
	}
}

#Preview {
	NATextField(title: "Test", value: .constant(""))
	//	NADatePicker(title: "Test", value: .constant(Date()))
}


