//
//  FirestoreHelper.swift
//  Navika
//
//  Created by A255085 on 03/09/24.
//

import Foundation
import FirebaseFirestore


class FirestoreHelper {
  static let shared = FirestoreHelper()
  
  private init() {}
  
  fileprivate func getDocumentId(from data: [String: Any]) -> String {
    if let id = data["id"] {
      return String(describing: id)
    }
    
    return UUID().uuidString
  }
  
  func create(document documentData: [String: Any], onCollection collection: NAFirestoreCollection) async throws -> [String: Any] {
    let documentId = self.getDocumentId(from: documentData)
    
    var data = documentData
    data["id"] = documentId
    
    return await withCheckedContinuation { continuation in
      let documentRef = Firestore.firestore().collection(collection.rawValue).document(documentId)
      
      documentRef.setData(data) { error in
        if let error = error {
          continuation.resume(throwing: error as! Never)
        } else {
          continuation.resume(returning: data)
        }
      }
    }
  }
  
  func create<T: Codable>(_ documentData: T, withId documentId: String, onCollection collection: NAFirestoreCollection) async throws -> T {
    
    return await withCheckedContinuation { continuation in
      let documentRef = Firestore.firestore().collection(collection.rawValue).document(documentId)
      
      do {
        try documentRef.setData(from: documentData) { error in
          if let error = error {
            continuation.resume(throwing: error as! Never)
          } else {
            continuation.resume(returning: documentData)
          }
        }
      } catch {
        continuation.resume(throwing: error as! Never)
      }
    }
  }
  
  func getDocument(with id: String, from collection: NAFirestoreCollection) async throws -> [String: Any] {
    let documentRef = Firestore.firestore().collection(collection.rawValue).document(id)
    
    do {
      let document = try await documentRef.getDocument()
      
      if document.exists {
        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
        print("Document data: \(dataDescription)")
        
        if let data = document.data() {
          return data
        }
      } else {
        print("Document does not exist")
      }
    } catch {
      print("Error getting document: \(error)")
    }
    
    return [:]
  }
  
  func getDocument<T: FirestoreModel>(with reference: DocumentReference) async -> T? {
    do {
      let document = try await reference.getDocument()
      
      if document.exists {
        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
        print("Document data: \(dataDescription)")
        
        do {
          let data = try document.data(as: T.self)
          return data
        }
        
      } else {
        print("Document does not exist")
      }
    } catch {
      print("Error getting document: \(error)")
    }
    
    return nil
  }
  
  func getDocuments<T: FirestoreModel>(from colection: NAFirestoreCollection) async throws -> [T] {
    do {
      let query = try await Firestore.firestore().collection(colection.rawValue).getDocuments()
      var documentList: [T] = []
      
      for document in query.documents {
        do {
          let docData = try document.data(as: T.self)
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
  
  
  func update(document: String, onCollection collection: NAFirestoreCollection, withData data: any FirestoreModel) async throws -> Void {
    let database = Firestore.firestore()
    let documentReference = database.collection(collection.rawValue).document(document)
    
    try await documentReference.updateData(data.dictionary)
  }
}

struct JSON {
  static let encoder = JSONEncoder()
}
extension Encodable {
  subscript(key: String) -> Any? {
    return dictionary[key]
  }
  var dictionary: [String: Any] {
    return (try? JSONSerialization.jsonObject(with: JSON.encoder.encode(self))) as? [String: Any] ?? [:]
  }
}
