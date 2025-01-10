//
//  HabitWithTasks.swift
//  Navika
//
//  Created by A255085 on 08/09/24.
//
import SwiftUI

struct HabitWithTasks: View {
  var habit: HabitModel
  var dateFilter: TaskDateFilter
  
  @State var habitTasks: [NATaskModel] = []
  
  var body: some View {
    ZStack {
      VStack(spacing: 20) {

      }
    }
    ZStack {
      VStack(spacing: 20) {
        VStack(alignment: .leading) {
          HStack(alignment: .top) {
            Image(systemName: habit.category.icon)
              .resizable()
              .frame(width: 16, height: 16)
              .padding(6)
              .foregroundStyle(.white)
              .background(habit.category.color)
              .clipShape(.rect(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 0) {
              Text(habit.category.title)
                .fontWeight(.medium)
              
              Text("4 related tasks")
                .font(.caption)
            }
            
            Spacer()
        
            Button("Edit") {
              print("pressed edit habit")
            }
          }
        }
        .opacity(habitTasks.count { $0.isSelected } == habitTasks.count ? 0.5 : 1)
        
        VStack(spacing: 0) {
          ForEach($habitTasks) { $task in
            HabitTaskRow(task: $task)
              .opacity(0.8)
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 60)
      }
      
      ForEach(1..<habitTasks.count + 1, id: \.self) { index in
        CurvedArrow(from: CGPoint(x: 15, y: 40), to: CGPoint(x: 50, y: (index + 1) * 66 - 40))
          .stroke(Color.gray.opacity(0.3), lineWidth: 2)
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
      }
    }
    .onChange(of: dateFilter) { oldValue, newValue in
      Task {
        let test: [NATaskModel] = await self.habit.tasks.asyncMap { taskRef in
          await FirestoreHelper.shared.getDocument(with: taskRef)
        }
        
        withAnimation {
          habitTasks = test.compactMap { $0 }.filter { task in
            if newValue == .all { return true }
            return task.actionsDays.contains { $0.contains(Date().getCurrentWeekDay().abbreviation.lowercased()) }
          }
        }
      }
    }
  }
}
