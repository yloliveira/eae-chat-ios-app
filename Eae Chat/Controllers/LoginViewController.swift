//
//  LoginViewController.swift
//  Eae Chat
//
//  Created by Yan Oliveira on 01/10/2022.
//  Copyright © 2019 yloliveira. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  @IBOutlet weak var emailTextfield: UITextField!
  @IBOutlet weak var passwordTextfield: UITextField!
  
  var authManager = FirebaseAuthManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    authManager.delegate = self
  }
  
  
  @IBAction func loginPressed(_ sender: UIButton) {
    if let email = emailTextfield.text, let password = passwordTextfield.text {
      authManager.login(email: email, password: password)
    }
  }
}

//MARK: - AuthManagerDelegate

extension LoginViewController: AuthManagerDelegate {
  func authManagerDidLogin() {
    performSegue(withIdentifier: Constants.LOGIN_TO_CHAT_SEGUE, sender: self)
  }
  
  func authManagerDidFailWithError(_ error: Error) {
    print(error.localizedDescription)
  }
}
