//
//  Int+Extensions.swift
//  Navika
//
//  Created by A255085 on 10/08/24.
//

import Foundation

extension Int {
	mutating func incrementUntil(limit: Int) {
		let nextNumber = self + 1
		if nextNumber > limit {
			self = limit
		} else {
			self = nextNumber
		}
	}
	
	mutating func decrementUntil(limit: Int = 0) {
		let nextNumber = self - 1
		if nextNumber < limit {
			self = limit
		} else {
			self = nextNumber
		}
	}
	
	func padLeft() -> String {
		if self < 10 {
			return "0\(self)"
		}
		
		return "\(self)"
	}
}
