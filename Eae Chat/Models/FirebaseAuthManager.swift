//
//  AuthManager.swift
//  Eae Chat
//
//  Created by Yan Oliveira on 04/10/22.
//  Copyright © 2022 yloliveira. All rights reserved.
//

import FirebaseAuth

struct FirebaseAuthManager: AuthManager {
  var delegate: AuthManagerDelegate?
  
  func register(email: String, password: String) {
    Auth.auth().createUser(withEmail: email, password: password) { authData, error in
      if let e = error {
        if delegate?.authManagerDidRegisterUser != nil {
          delegate?.authManagerDidFailWithError!(e)
        }
      } else {
        if delegate?.authManagerDidRegisterUser != nil {
          delegate?.authManagerDidRegisterUser!()
        }
      }
    }
  }
  
  func login(email: String, password: String) {
    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
      if let e = error {
        if delegate?.authManagerDidRegisterUser != nil {
          delegate?.authManagerDidFailWithError!(e)
        }
      } else {
        if delegate?.authManagerDidLogin != nil {
          delegate?.authManagerDidLogin!()
        }
      }
    }
  }
  
  func logout() {
    do {
      try Auth.auth().signOut()
      if delegate?.authManagerDidLogout?() != nil {
        delegate?.authManagerDidLogout!()
      }
    } catch let signOutError as NSError {
      if delegate?.authManagerDidRegisterUser != nil {
        delegate?.authManagerDidFailWithError!(signOutError)
      }
    }
    
  }
  
  func getCurrentUserEmail() -> String? {
    return Auth.auth().currentUser?.email
  }
}
