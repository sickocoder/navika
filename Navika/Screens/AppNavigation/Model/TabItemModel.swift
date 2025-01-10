//
//  TabItemModel.swift
//  Navika
//
//  Created by A255085 on 06/08/24.
//

import Foundation

struct TabItemModel: Identifiable {
	let id = UUID().uuidString
	
	let label: String
	let imageName: String
	let tag: TabsEnum
}
