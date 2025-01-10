//
//  View+Extensions.swift
//  Navika
//
//  Created by A255085 on 03/08/24.
//

import SwiftUI

extension View {
	func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
		self.clipShape( RoundedCorner(radius: radius, corners: corners) )
	}
	
	func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
		overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
	}
}
