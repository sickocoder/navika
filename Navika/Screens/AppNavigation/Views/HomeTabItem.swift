//
//  HomeTabItem.swift
//  Navika
//
//  Created by A255085 on 06/08/24.
//

import SwiftUI

struct HomeTabItem: View {
	let label: String
	let imageName: String
	
	let selected: Bool
	
	var body: some View {
		HStack {
			Image(systemName: selected ? imageName : "house")
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
    HomeTabItem(label: "", imageName: "", selected: false)
}
