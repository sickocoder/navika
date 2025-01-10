//
//  TabItem.swift
//  Navika
//
//  Created by A255085 on 06/08/24.
//

import SwiftUI

struct TabItem: View {
	let label: String
	let imageName: String
	
	let selected: Bool
	
	var body: some View {
		HStack {
			Image(systemName: imageName)
			if selected {
				Text("\(label)")
			}
		}
		.bold()
		.padding(.vertical, 14)
		.padding(.horizontal, 24)
		.background(selected ? .accent : .clear)
		.clipShape(.capsule)
		
	}
}

#Preview {
    TabItem(label: "", imageName: "", selected: false)
}
