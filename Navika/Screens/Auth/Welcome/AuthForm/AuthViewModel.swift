//
//  AuthViewModel.swift
//  Navika
//
//  Created by A255085 on 02/09/24.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import FirebaseCore
import FirebaseFirestore

class AuthViewModel {
  fileprivate func authWithGoogle(_ presentingViewController: UIViewController, completion: @escaping (AuthDataResult?, (Error)?) -> Void) {
    
    GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) {  signinResult, error in
      guard error == nil else {
        return
      }
      
      guard
        let user = signinResult?.user,
        let idToken = signinResult?.user.idToken?.tokenString
      else {
        return
      }
      
      let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
      
      Auth.auth().signIn(with: credentials) { result, error in
        completion(result, error)
      }
    }
  }
  
  fileprivate func authWithApple(completion: @escaping (AuthDataResult?, Error?) -> Void) {
    
  }
  
  func googleAuth(_ presentingViewController: UIViewController) async throws -> AuthDataResult {
    await withCheckedContinuation { continuation in
      self.authWithGoogle(presentingViewController) { result, error in
        if let error = error {
          continuation.resume(throwing: error as! Never)
        }
        
        if let result = result {
          let user = result.user
          
          continuation.resume(returning: result)
          Task {
            await self.createUserInFirestore(user: user)
          }
        }
      }
    }
  }
  
  func createUserInFirestore(user: User?) async {
    guard let user = user else { return }
    
    let userData = [
      "id": user.uid,
      "uid": user.uid,
      "displayName": user.displayName ?? "",
      "email": user.email ?? "",
      "photoURL": user.photoURL?.absoluteString ?? ""
    ]
    
    _ = try! await FirestoreHelper.shared.create(document: userData, onCollection: .users)
    
  }
}

