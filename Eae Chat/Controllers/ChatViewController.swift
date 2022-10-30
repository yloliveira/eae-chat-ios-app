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
  var chatManager = FirebaseChatManager()
  var messages: [ChatMessage] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    authManager.delegate = self
    chatManager.delegate = self
    title = Constants.APP_NAME
    navigationItem.hidesBackButton = true
    
    chatManager.listMessages()
    
    tableView.register(UINib(nibName: Constants.CHAT_TABLE_VIEW_NIB_NAME, bundle: nil), forCellReuseIdentifier: Constants.CHAT_TABLE_VIEW_REUSABLE_CELL)
  }
  
  @IBAction func LogoutPressed(_ sender: UIBarButtonItem) {
    authManager.logout()
  }
  
  @IBAction func sendPressed(_ sender: UIButton) {
    if let body = messageTextfield.text, let sender = authManager.getCurrentUserEmail() {
      chatManager.sendMessage(message: ChatMessage(sender: sender, body: body))
    }
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

//MARK: - ChatManagerDelegate

extension ChatViewController: ChatManagerDelegate {
  func chatManagerDidSendMessage(message: ChatMessage) {
    messageTextfield.text = ""
  }
  
  func chatManagerDidListMessages(messages: [ChatMessage]) {
    DispatchQueue.main.async {
      self.messages.append(contentsOf: messages)
      self.tableView.reloadData()
    }
  }
  
  func chatManagerDidFailWithError(_ error: Error) {
    print(error.localizedDescription)
  }
}

//MARK: - UITableViewDataSource

extension ChatViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CHAT_TABLE_VIEW_REUSABLE_CELL, for: indexPath) as! ChatMessageCell
    cell.messageLabel.text = messages[indexPath.row].body
    return cell
  }
}
