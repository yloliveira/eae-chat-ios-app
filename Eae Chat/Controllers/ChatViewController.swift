//
//  ChatViewController.swift
//  Eae Chat
//
//  Created by Yan Oliveira on 01/10/2022.
//  Copyright © 2019 yloliveira. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var messageTextfield: UITextField!
  
  var authManager = FirebaseAuthManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    authManager.delegate = self
    title = Constants.APP_NAME
    navigationItem.hidesBackButton = true
  }
  
  @IBAction func LogoutPressed(_ sender: UIBarButtonItem) {
    authManager.logout()
  }
  
  @IBAction func sendPressed(_ sender: UIButton) {
  }
}

//MARK: - AuthManagerDelegate

extension ChatViewController: AuthManagerDelegate {
  func authManagerDidLogout() {
    navigationController?.popToRootViewController(animated: true)
  }
  
  func authManagerDidFailWithError(_ error: Error) {
    print(error.localizedDescription)
  }
}
