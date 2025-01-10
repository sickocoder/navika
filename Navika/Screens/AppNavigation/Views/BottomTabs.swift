//
//  BottomTabs.swift
//  Navika
//
//  Created by A255085 on 06/08/24.
//

import SwiftUI

struct BottomTabs: View {
	let selectedTab: String
	let onTabChange: (_ tag: String) -> ()
	
	var body: some View {
		HStack(spacing: 20) {
			ForEach(AppNavigationConstants.appTabs) { tab in
				if tab.tag == .home {
					
					HomeTabItem(
						label: tab.label,
						imageName: tab.imageName,
						selected: tab.tag.rawValue == selectedTab
					)
					.onTapGesture {
						if tab.tag.rawValue != selectedTab {
							self.onTabChange(tab.tag.rawValue)
						}
					}
				} else {
					TabItem(
						label: tab.label,
						imageName: tab.imageName,
						selected: tab.tag.rawValue == selectedTab
					)
					.onTapGesture {
						self.onTabChange(tab.tag.rawValue)
					}
				}
			}
		}
		.padding(6)
		.background(Color.navikaBlack)
		.foregroundColor(.white)
		.clipShape(.capsule)
		.padding(.horizontal)
	}
}

#Preview {
	BottomTabs(selectedTab: "") { tag in
		
	}
}


