//
//  WelcomeScreen.swift
//  Navika
//
//  Created by A255085 on 02/09/24.
//

import SwiftUI

struct WelcomeScreen: View {
  let screenHeight = UIScreen.main.bounds.height
//  @Environment(AppRouting.self) private var router
  
  @State private var shouldShowAuthOptions: Bool = false
  var body: some View {
      ZStack {
        Color.defaultBackground
          .ignoresSafeArea()
        
        VStack {
          Image(.welcomeArt)
            .resizable()
            .scaledToFill()
            .frame(maxHeight: screenHeight * (shouldShowAuthOptions ? 0.4 : 0.6))
            .border(width: 1.5, edges: [.bottom], color: .gray.opacity(0.3))
            .clipped()
            .ignoresSafeArea()
          
          if shouldShowAuthOptions {
            AuthForm()
              .padding(.top, -30)
              .transition(.move(edge: .trailing))
          } else {
            WelcomeView(onNextPress: {
              withAnimation {
                shouldShowAuthOptions.toggle()
              }
            })
            .transition(.move(edge: .leading))
          }
        }
      }
  }
}



#Preview {
  WelcomeScreen()
    .environment(AppRouting())
}

