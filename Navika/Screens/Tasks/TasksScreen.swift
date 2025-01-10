//
//  TasksScreen.swift
//  Navika
//
//  Created by A255085 on 03/09/24.
//

import SwiftUI

enum TaskDateFilter {
  case today
  case all
}

struct TasksScreen: View {
  @Environment(HabitTasksRouting.self) private var route
  @EnvironmentObject var habitSettings: HabitSettings
  
  @State private var taskDateFilter: TaskDateFilter = .today
  @State private var habitsList: [HabitModel] = []
  
  var body: some View {
    VStack(spacing: 0) {
      Picker("", selection: $taskDateFilter) {
        Text("For today").tag(TaskDateFilter.today)
        Text("All tasks").tag(TaskDateFilter.all)
      }
      .pickerStyle(.segmented)
      .padding(.horizontal)
      
      ScrollView {
        VStack(alignment: .leading, spacing: 40) {
          ForEach(habitsList.filter({ $0.tasks.count > 0 })) { habit in
            NavigationLink {
              SetFrequencyStep(habitModel: habit)
            } label: {
              HabitWithTasks(habit: habit, dateFilter: taskDateFilter)
                .tint(Color.navikaBlack)
            }
          }
        }
        .padding()
        .padding(.top)
      }
    }
    .navigationTitle("Tasks")
    .onChange(of: taskDateFilter) { oldValue, newValue in
      Task {
        do {
          let habits: [HabitModel] = try await FirestoreHelper.shared.getDocuments(from: .habits)
          
          if newValue == .all {
            withAnimation { self.habitsList = habits }
          } else {
            withAnimation { self.habitsList = habits.filter { $0.isForToday() } }
          }
          
        } catch {
          print(error)
        }
      }
    }
  }
}

#Preview {
  NavigationView {
    TasksScreen()
      .environmentObject(HabitSettings())
  }
}
