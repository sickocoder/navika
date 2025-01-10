//
//  Route.swift
//  Navika
//
//  Created by A255085 on 06/09/24.
//

enum Route: Hashable {
  case unauthenticated(AnauthenticatedRoute)
  case authenticated(AuthenticatedRoute)
  
  enum AnauthenticatedRoute: Hashable {
    case emailAndPasswordForm
  }
  
  enum AuthenticatedRoute: Hashable {
    case home
    case habit(HabitModel)
    case editHabit(HabitModel)
  }
}

enum HabitTaskRoute: Hashable {
  case editHabit(HabitModel)
}
