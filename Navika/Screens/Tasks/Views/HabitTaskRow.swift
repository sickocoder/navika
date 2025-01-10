//
//  HabitTaskRow.swift
//  Navika
//
//  Created by A255085 on 08/09/24.
//
import SwiftUI

struct HabitTaskRow: View {
  @Binding var task: NATaskModel
  
  var body: some View {
    HStack(alignment: .center) {
      Image(systemName: task.isSelected ? "checkmark.square.fill" : "square")
        .resizable()
        .frame(width: 18, height: 18)
        .contentTransition(.symbolEffect(.replace))
      
      Text("\(task.title)")
      
      Spacer()
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: 50)
    .frame(height: 50)
    .background(.gray.opacity(0.1))
    .clipShape(.rect(cornerRadius: 12))
    .frame(height: 66)
    .onTapGesture {
      withAnimation {
        task.isSelected.toggle()
      }
      
      Task {
        do {
          try await TasksService.updateTask(task)
        } catch {
          print(error)
        }
      }
    }
  }
}
