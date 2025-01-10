//
//  NAContainerView.swift
//  Navika
//
//  Created by A255085 on 03/08/24.
//

import SwiftUI

struct NAContainerView<Content: View>: View {
	var content: () -> Content
	
	var body: some View {
		ZStack {
			Color
				.defaultBackground
				.ignoresSafeArea(.all)
			
			content()
		}
	}
}

#Preview {
	NAContainerView {
		Text("test")
	}
}

