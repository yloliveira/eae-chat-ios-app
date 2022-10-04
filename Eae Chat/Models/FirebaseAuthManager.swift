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
        delegate?.authManagerDidRegisterFailWithError(e)
      } else {
        delegate?.authManagerDidRegisterUser()
      }
    }
  }
}
