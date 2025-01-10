//
//  CollapsableHeader.swift
//  Navika
//
//  Created by A255085 on 28/08/24.
//

import SwiftUI

struct CollapsableHeaderView<Header: View, Content: View>: View  {
	@State var progress: CGFloat = 0
	
	let header: Header
	let content: Content
	
	init(
		@ViewBuilder header: () -> Header,
		@ViewBuilder content: () -> Content
	) {
		self.header = header()
		self.content = content()
	}
	
	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			content
				.frame(minHeight: UIScreen.main.bounds.height * 0.7, alignment: .top)
				.padding(.bottom, 55 + 80)
				.background(.white)
				.cornerRadius(40 * (1 - self.progress))
				.overlay(content: {
					RoundedRectangle(cornerRadius: 40 * (1 - self.progress))
						.stroke(.gray.opacity(0.5), lineWidth: 1)
				})
				.offset(y: progress * 55)
				.safeAreaInset(edge: .top, spacing: 0) {
					header
						.overlay(Divider().frame(height: 2 * self.progress).opacity(self.progress >= 1.0 ? 1 : 0), alignment: .bottom)
						.visualEffect { content, proxy in
							content.offset(y: self.offsetY(proxy))
						}
				}
		}
		.onScrollGeometryChange(for: CGFloat.self) { scrollGeometry in
			scrollGeometry.contentOffset.y + scrollGeometry.contentInsets.top
		} action: { oldValue, newValue in
			progress = max(min(newValue / 55, 1), 0)
		}
	}
	
	nonisolated private func offsetY(_ proxy: GeometryProxy) -> CGFloat {
		let minY = proxy.frame(in: .scrollView(axis: .vertical)).minY
		return minY > 0 ? 0 : -minY
	}
}
