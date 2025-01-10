//
//  AppRouting.swift
//  Navika
//
//  Created by A255085 on 06/09/24.
//
import SwiftUI

@Observable class AppRouting {
  var routes: [Route] = []
  
  func append(route: Route) {
    self.routes.append(route)
  }
  
  @ViewBuilder func destination(for route: Route) -> some View {
    switch route {
    case .unauthenticated(let route): handleUnauthenticated(route)
    case .authenticated(let route): handleAuthenticated(route)
    }
  }
  
  @ViewBuilder func handleUnauthenticated(_ route: Route.AnauthenticatedRoute) -> some View {
    switch route {
    case .emailAndPasswordForm: SignInWithEmailPasswordForm()
    }
  }
  
  @ViewBuilder func handleAuthenticated(_ route: Route.AuthenticatedRoute) -> some View {
    switch route {
    case .home: AppNavigationScreen()
    case .habit(let habitDetail): HabitDetails(habitDetails: habitDetail)
    case .editHabit(let habitModel): SetFrequencyStep(habitModel: habitModel)
    }
  }
}

@Observable class HabitTasksRouting {
  var routes: [HabitTaskRoute] = []
  
  func append(route: HabitTaskRoute) {
    self.routes.append(route)
  }
  
  @ViewBuilder func destination(for route: HabitTaskRoute) -> some View {
    switch route {
    case .editHabit(let habitModel): SetFrequencyStep(habitModel: habitModel)
    }
  }
}
