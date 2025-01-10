//
//  FTUser.swift
//  Navika
//
//  Created by A255085 on 04/09/24.
//

public protocol FirestoreModel: Identifiable, Codable {}

struct FTUser: FirestoreModel {
  let uid: String
  let id: String
  let displayName: String
  let photoURL: String
  let email: String
}
