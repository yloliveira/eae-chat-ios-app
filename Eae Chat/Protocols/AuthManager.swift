//
//  AuthManager.swift
//  Eae Chat
//
//  Created by Yan Oliveira on 04/10/22.
//  Copyright © 2022 yloliveira. All rights reserved.
//

protocol AuthManager {
  var delegate: AuthManagerDelegate? { get }
  func register(email: String, password: String) -> Void
}

protocol AuthManagerDelegate {
  func authManagerDidRegisterUser() -> Void
  func authManagerDidRegisterFailWithError(_ error: Error) -> Void
}
