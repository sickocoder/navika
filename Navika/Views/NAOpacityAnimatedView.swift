//
//  NAOpacityAnimatedView.swift
//  Navika
//
//  Created by A255085 on 09/08/24.
//

import SwiftUI

struct NAOpacityAnimatedView<Content: View>: View {
	@State private var animate: Bool = false

	let content: () -> Content
	
	var body: some View {
		VStack {
			if animate {
				content()
					.transition(.opacity)
			}
		}
		.onAppear(perform: {
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
				withAnimation {
					animate = true
				}
			}
		})
	}
}

#Preview {
	NAOpacityAnimatedView {
		Text("test")
	}
}
