//
//  TasksService.swift
//  Navika
//
//  Created by A255085 on 06/01/25.
//

import FirebaseFirestore

class TasksService {
  enum GetTasksFilter {
    case today
    case all
  }
  
  static func getTasks(for: GetTasksFilter) async throws -> [NATaskModel] {
    do {
      var documentList: [NATaskModel] = []
      let query = try await Firestore
        .firestore()
        .collection(NAFirestoreCollection.tasks.rawValue)
        .whereField("actionsDay", arrayContains: Date().getCurrentWeekDay().day)
        .getDocuments()
      
     
      
      
      for document in query.documents {
        do {
          let docData = try document.data(as: NATaskModel.self)
          documentList.append(docData)
        } catch {
          print("--> \(error)")
        }
      }
      return documentList
    } catch {
      print("Error getting documents: \(error)")
    }
    return []
  }
  
  
  static func updateTask(_ task: NATaskModel) async throws {
    do {
      try await FirestoreHelper.shared.update(document: task.id, onCollection: .tasks, withData: task)
    } catch {
      throw error
    }
  }
}
