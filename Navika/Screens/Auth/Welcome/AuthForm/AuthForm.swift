//
//  AuthForm.swift
//  Navika
//
//  Created by A255085 on 02/09/24.
//

import SwiftUI

struct AuthForm: View {
  @AppStorage("isUserSignedIn") var isUserSignedIn: Bool = false
  private let authViewMode = AuthViewModel()
  
  var body: some View {
    VStack(spacing: 60) {
      VStack(spacing: 14) {
        Text("Login or sign up")
          .font(.title.bold())
        
        Text("Please select your preferred method to continue setting up your account")
          .multilineTextAlignment(.center)
          .padding(.horizontal, 40)
      }
      
      VStack(spacing: 14) {
        Button {} label: {
          Text("Continue with Email")
            .font(.title3.bold())
            .frame(maxWidth: .infinity, maxHeight: 40)
        }
        .buttonStyle(.borderedProminent)
        .padding(.horizontal)
        
        Button {} label: {
          Text("Continue with Phone")
            .font(.title3.bold())
            .frame(maxWidth: .infinity, maxHeight: 40)
        }
        .buttonStyle(.bordered)
        .padding(.horizontal)
        
        HStack(spacing: 14) {
          Button {
            guard let presentingViewController = (UIApplication.shared.connectedScenes.first
                                                  as? UIWindowScene)?.windows.first?.rootViewController
            else { return }
            
            Task {
              do {
                let authResult = try await authViewMode.googleAuth(presentingViewController)
                self.isUserSignedIn = true
              } catch {
                print(error)
              }
            }
            
          } label: {
            Image(.googleLogo)
              .font(.title3.bold())
              .frame(maxWidth: .infinity, maxHeight: 40)
          }
          .buttonStyle(.bordered)
          
          Button {} label: {
            Image(systemName: "apple.logo")
              .font(.title2.bold())
              .foregroundStyle(.black)
              .frame(maxWidth: .infinity, maxHeight: 40)
          }
          .buttonStyle(.bordered)
        }
        .padding(.horizontal)
        
        Spacer()
        
        Text("If you are creating a new account, [Terms & Conditions](https://google.com) and [Privacy Policy](https://google.com) will apply.")
          .font(.callout)
          .lineLimit(2)
          .multilineTextAlignment(.center)
          .padding(.horizontal)
      }
    }
  }
}

#Preview {
  AuthForm()
}

