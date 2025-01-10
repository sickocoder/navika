//
//  NAButton.swift
//  Navika
//
//  Created by A255085 on 12/08/24.
//

import SwiftUI

struct NAPrimaryButon: View {
	let title: LocalizedStringKey
	let action: () -> ()
	
	var body: some View {
		Button(action: action, label: {
			Text(title)
				.bold()
				.padding(.vertical, 10)
				.padding(.horizontal)
				.frame(maxWidth: .infinity)
		})
		.buttonStyle(BorderedProminentButtonStyle())
	}
}

struct NACustomButton: View {
	let title: LocalizedStringKey
	let action: () -> ()
	
	var body: some View {
		Button {
			self.action()
		} label: {
			HStack {
				Spacer()
				Text(title)
					.foregroundStyle(.navikaBlack)
				Spacer()
			}
			.bold()
			.padding()
		}
		.buttonStyle(BorderlessButtonStyle())
	}
}
