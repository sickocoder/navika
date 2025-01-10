//
//  SignInWithEmailPasswordForm.swift
//  Navika
//
//  Created by A255085 on 05/09/24.
//

import SwiftUI

struct SignInWithEmailPasswordForm: View {
  var body: some View {
    ZStack {
      Color.defaultBackground
        .ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 14) {
        VStack(alignment: .leading, spacing: 10) {
          Text("Your details")
            .font(.title2.bold())
          
          Text("Lorem ipsum dolor sit amet, adipiscing elit, sed eiusmod tempor incididunt.")
        }
        .padding(.bottom)
        
        NATextField(title: "First name", value: .constant(""))
        NATextField(title: "Last name", value: .constant(""))
        NATextField(title: "Email", value: .constant(""), keyboardType: .emailAddress)
        
        Spacer()
      }
      .padding()
    }
  }
}

#Preview {
  SignInWithEmailPasswordForm()
}
