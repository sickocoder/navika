//
//  WelcomeView.swift
//  Navika
//
//  Created by A255085 on 02/09/24.
//

import SwiftUI

struct WelcomeView: View {
  let onNextPress: () -> ()
  
  var body: some View {
    VStack(spacing: 14) {
      Spacer()
      
      Text("Welcome to App")
        .font(.title.bold())
      
      Text("Here’s a good place for a brief overview of the app or it’s key features.")
        .multilineTextAlignment(.center)
        .padding(.horizontal, 40)
      
      Spacer()
      
      Button {
        onNextPress()
      } label: {
        Text("Get Started")
          .font(.title3.bold())
          .frame(maxWidth: .infinity)
          .frame(height: 40)
      }
      .buttonStyle(.borderedProminent)
      .padding()
      
    }
  }
}
