//
//  EmptyList.swift
//  Navika
//
//  Created by A255085 on 03/09/24.
//

import SwiftUI
import Lottie

struct EmptyList: View {
  let label: String
  
  var body: some View {
    VStack(alignment: .center) {
      LottieView(animation: .named("sloth-animation"))
        .animationSpeed(0.4)
        .looping()
        .frame(width: 200, height: 200)
      
      Text("\(label)")
        .font(.title2)
        .fontWeight(.heavy)
        .multilineTextAlignment(.center)
        .opacity(0.4)
    }
    
  }
}
