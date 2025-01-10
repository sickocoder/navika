//
//  NAFormContainer.swift
//  Navika
//
//  Created by A255085 on 10/08/24.
//

import SwiftUI

struct NAFormContainer<Content: View>: View {
	@ViewBuilder let content: () -> Content
	
	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			content()
				.padding(.top, 4)
		}
		.background(Color.navikaBlack.opacity(0.03))
		.clipShape(.rect(cornerRadius: 12))
	}
}

#Preview {
	NAFormContainer {
		Text("a")
	}
}
