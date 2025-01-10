//
//  NAStepView.swift
//  Navika
//
//  Created by A255085 on 09/08/24.
//

import SwiftUI

struct NAStepView<Content: View>: View {
  @EnvironmentObject var habitSettings: HabitSettings
  @Environment(\.dismiss) var dismiss
  
  private let paginationLimit: Int = CreateHabitConstants.createHabitAvailableSteps.count - 1
  @Binding var currentPage: Int
  
  let content: () -> Content
  
  var isLastPage: Bool {
    currentPage == paginationLimit
  }
  
  var body: some View {
    VStack {
      content()
      
      HStack(spacing: 20) {
        Button(action: {
          currentPage.decrementUntil(limit: 0)
        }, label: {
          Text("Go Back")
            .bold()
            .padding(.vertical, 10)
            .padding(.horizontal, 30)
        })
        .buttonStyle(PlainButtonStyle())
        
        Button(action: {
          if isLastPage {
            if let habit = self.habitSettings.makeHabitModel() {
              habitSettings.habitList.append(habit)
              
              Task {
                do {
                  _ = try await FirestoreHelper.shared.create(habit, withId: habit.id, onCollection: .habits)
                } catch {
                  print("something went wrong")
                }
              }
              
            }
            self.dismiss()
          } else {
            currentPage.incrementUntil(limit: paginationLimit)
          }
        }, label: {
          Text(isLastPage ? "Create Habit" : "Next")
            .bold()
            .padding(.vertical, 10)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
        })
        .buttonStyle(.borderedProminent)
      }
      .padding(.horizontal)
      .padding(.top)
      .border(width: 1, edges: [.top], color: .navikaBlack.opacity(0.1))
      .padding(.bottom, 10)
    }
  }
}

#Preview {
  NAStepView(currentPage: .constant(0)) {
    Text("test")
  }
  .environmentObject(HabitSettings())
}

