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
      chatManager.sendMessage(message: ChatMessage(sender: sender, body: body, date: Date().timeIntervalSince1970))
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
      let indexPath = IndexPath(row: messages.count - 1, section: 0)
      self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
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
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy - HH:mm"
    let message = messages[indexPath.row]
    let loggedUserEmail = authManager.getCurrentUserEmail()
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CHAT_MESSAGE_REUSABLE_CELL, for: indexPath) as! ChatMessageCell
    
    if loggedUserEmail == message.sender {
      cell.messageBubble.backgroundColor = UIColor(named: "BrandPurple")
      cell.messageBubbleTrailingConstraint.constant = 10
      cell.messageBubbleLeadingConstraint.constant = 40
      cell.senderLabel.textAlignment = NSTextAlignment.right
      
    } else {
      cell.messageBubble.backgroundColor = UIColor(named: "BrandLightPurple")
      cell.messageBubbleTrailingConstraint.constant = 40
      cell.messageBubbleLeadingConstraint.constant = 10
      cell.senderLabel.textAlignment = NSTextAlignment.left
    }
    
    cell.senderLabel.text = message.sender
    cell.dateLabel.text = dateFormatter.string(from: Date.init(timeIntervalSince1970: message.date))
    cell.messageLabel.text = message.body
    
    return cell
  }
}
