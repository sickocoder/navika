//
//  NASlideView.swift
//  Navika
//
//  Created by A255085 on 09/08/24.
//

import SwiftUI

struct NASlideView<Content: View>: View {
	@State private var animate: Bool = false
	
	let edge: Edge
	let content: () -> Content
	
	var body: some View {
		VStack {
			if animate {
				content()
					.transition(.move(edge: self.edge))
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
