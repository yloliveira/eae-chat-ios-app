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
  var messages: [ChatMessage] = [
    ChatMessage(sender: "1@2.com", body: "hey"),
    ChatMessage(sender: "1@3.com", body: "hello"),
    ChatMessage(sender: "1@4.com", body: "whats up")
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
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

//MARK: - UITableViewDataSource

extension ChatViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CHAT_TABLE_VIEW_REUSABLE_CELL, for: indexPath)
    cell.textLabel?.text = messages[indexPath.row].body
    return cell
  }
}
