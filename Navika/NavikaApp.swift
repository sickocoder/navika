//
//  NavikaApp.swift
//  Navika
//
//  Created by A255085 on 03/08/24.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    FirebaseApp.configure()
    return true
  }
  
  func application(_ app: UIApplication,
                   open url: URL,
                   options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    return GIDSignIn.sharedInstance.handle(url)
  }
}

@main
struct NavikaApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @StateObject var habitSettings = HabitSettings()
  
	var body: some Scene {
		WindowGroup {
			ContentView()
        .preferredColorScheme(.light)
        .environment(AppRouting())
        .environment(HabitTasksRouting())
        .environmentObject(habitSettings)
      
//      CurvedArrowView()
		}
	}
}

