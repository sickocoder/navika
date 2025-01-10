//
//  AppNavigationConstants.swift
//  Navika
//
//  Created by A255085 on 06/08/24.
//

import Foundation

class AppNavigationConstants {
	static let appTabs: [TabItemModel] = [
		.init(label: "New Habit", imageName: "plus", tag: .home),
		.init(label: "Tasks", imageName: "list.dash.header.rectangle", tag: .task),
		.init(label: "Settings", imageName: "gearshape", tag: .settings)
	]
}
