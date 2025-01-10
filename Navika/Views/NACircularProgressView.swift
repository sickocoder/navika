//
//  CircularProgressView.swift
//  Navika
//
//  Created by A255085 on 22/08/24.
//
import SwiftUI

struct NACircularProgressView: View {
	var color: Color = .pink
	var lineWidth: CGFloat = 20
	
	@Binding var progress: Double
	
	var body: some View {
		ZStack { // 1
			Circle()
				.stroke(
					self.color.opacity(0.5),
					lineWidth: lineWidth
				)
			Circle() // 2
				.trim(from: 0, to: progress)
				.stroke(
					self.color,
					style: StrokeStyle(
						lineWidth: lineWidth,
						lineCap: .round
					)
				)
				.rotationEffect(.degrees(-90))
				.animation(.easeOut, value: progress)
		}
	}
}

#Preview {
	NACircularProgressView(progress: .constant(0.7))
		.frame(width: 80, height: 80)
}
