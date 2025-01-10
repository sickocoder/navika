//
//  DateValue.swift
//  Navika
//
//  Created by A255085 on 02/09/24.
//

import Foundation

struct DateValue: Identifiable {
  let id = UUID().uuidString
  
  let day: Int
  let date: Date
}
