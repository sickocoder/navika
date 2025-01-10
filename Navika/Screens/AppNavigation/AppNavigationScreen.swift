//
//  AppNavigationScreen.swift
//  Navika
//
//  Created by A255085 on 06/08/24.
//

import SwiftUI

struct AppNavigationScreen: View {
  @Environment(HabitTasksRouting.self) private var habitTasksRouter
  
  @State var selectedTab: String = TabsEnum.home.rawValue
  @State var shouldHideTabBar: Bool = false
  
  @State var habitModel: HabitModel? = nil
  
  var body: some View {
    @Bindable var habitTasksRouter = habitTasksRouter
    
    ZStack(alignment: .bottom) {
      TabView(selection: $selectedTab) {
        NavigationStack {
          HomeScreen(shouldHideTabBar: $shouldHideTabBar)
            .navigationDestination(isPresented: $shouldHideTabBar) {
              CreateHabitScreen()
            }
        }
        .tag(AppNavigationConstants.appTabs[0].tag.rawValue)
        .toolbar(.hidden, for: .tabBar)
        
        NavigationView {
          TasksScreen()
//            .navigationDestination(for: HabitTaskRoute.self) { route in
//              habitTasksRouter.destination(for: route)
//            }
        }
        .tag(AppNavigationConstants.appTabs[1].tag.rawValue)
        .toolbar(.hidden, for: .tabBar)
        
        Text("test 1")
          .tag(AppNavigationConstants.appTabs[2].tag.rawValue)
          .toolbar(.hidden, for: .tabBar)
      }
      .ignoresSafeArea(.all)
      
      VStack {
        if !shouldHideTabBar {
          BottomTabs(selectedTab: self.selectedTab) { tag in
            withAnimation {
              self.selectedTab = tag
            }
          }
          .transition(.move(edge: .bottom).combined(with: .opacity))
        }
      }
      .animation(.bouncy, value: shouldHideTabBar)
    }
  }
}

#Preview {
  AppNavigationScreen()
}
