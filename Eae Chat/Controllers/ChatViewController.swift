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
    
    tableView.register(UINib(nibName: Constants.CHAT_MESSAGE_NIB_NAME, bundle: nil), forCellReuseIdentifier: Constants.CHAT_MESSAGE_REUSABLE_CELL)
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
    self.messages = messages
    DispatchQueue.main.async {
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
    let message = messages[indexPath.row]
    let loggedUserEmail = authManager.getCurrentUserEmail()
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CHAT_MESSAGE_REUSABLE_CELL, for: indexPath) as! ChatMessageCell
    
    if loggedUserEmail == message.sender {
      cell.messageBubble.backgroundColor = UIColor(named: "BrandPurple")
      cell.messageBubbleTrailingConstraint.constant = 0
      cell.messageBubbleLeadingConstraint.constant = 30
      cell.infoLabelTrailingConstraint.constant = 0
      cell.infoLabelLeadingConstraint.constant = 30
      cell.infoLabel.textAlignment = NSTextAlignment.right
      cell.infoLabel.text = "03/11/2022 - 19:00"
    } else {
      cell.messageBubble.backgroundColor = UIColor(named: "BrandLightPurple")
      cell.messageBubbleTrailingConstraint.constant = 30
      cell.messageBubbleLeadingConstraint.constant = 0
      cell.infoLabelTrailingConstraint.constant = 30
      cell.infoLabelLeadingConstraint.constant = 0
      cell.infoLabel.text = message.sender
    }
    
    cell.messageLabel.text = message.body
    
    return cell
  }
}
