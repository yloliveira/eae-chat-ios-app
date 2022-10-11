//
//  AuthManager.swift
//  Eae Chat
//
//  Created by Yan Oliveira on 04/10/22.
//  Copyright © 2022 yloliveira. All rights reserved.
//

import Foundation

protocol AuthManager {
  var delegate: AuthManagerDelegate? { get }
  func register(email: String, password: String) -> Void
  func login(email: String, password: String) -> Void
  func logout() -> Void
  func getCurrentUserEmail() -> String?
}

@objc protocol AuthManagerDelegate {
  @objc optional func authManagerDidRegisterUser() -> Void
  @objc optional func authManagerDidLogin() -> Void
  @objc optional func authManagerDidLogout() -> Void
  @objc optional func authManagerDidFailWithError(_ error: Error) -> Void
}
