//
//  ContentView.swift
//  Navika
//
//  Created by A255085 on 03/08/24.
//

import SwiftUI


struct ContentView: View {
  @AppStorage("isUserSignedIn") var isUserSignedIn: Bool = false
  @Environment(AppRouting.self) private var router
  
	var body: some View {
    @Bindable var router = router
    
    NavigationStack(path: $router.routes) {
      ZStack {
        if isUserSignedIn {
          AppNavigationScreen()
        } else {
          WelcomeScreen()
        }
      }
      .navigationDestination(for: Route.self) { route in
        router.destination(for: route)
      }
    }
    
	}
}


#Preview {
	ContentView()
    .environment(AppRouting())
}



