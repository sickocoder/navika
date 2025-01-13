//
//  SetFrequencyStep+ViewModel.swift
//  Navika
//
//  Created by A255085 on 13/01/25.
//
import SwiftUI

final class SetFrequencyViewModel: ObservableObject {
  @Published public var shouldShowRepeatitionPicker: Bool = false
  @Published public var shouldShowReminderPicker: Bool = false
  
  @Published public var description: String = ""
  @Published public var repetitionDays: Set<Int> = []
  
  @Published public var startDate = Date()
  @Published public var reminders: [Date] = []
}
