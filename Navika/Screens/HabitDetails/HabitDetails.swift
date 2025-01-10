//
//  HabitDetails.swift
//  Navika
//
//  Created by A255085 on 06/09/24.
//

import SwiftUI

struct HabitDetails: View {
  let habitDetails: HabitModel
  
  var body: some View {
    VStack {
      Text("Habit Details")
      Text("\(habitDetails.description)")
    }
  }
}
