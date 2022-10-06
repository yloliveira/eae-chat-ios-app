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
    ChatMessage(sender: "1@4.com", body: "Mussum Ipsum, cacilds vidis litro abertis. Posuere libero varius. Nullam a nisl ut ante blandit hendrerit. Aenean sit amet nisi.Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum.Leite de capivaris, leite de mula manquis sem cabeça.Interessantiss quisso pudia ce receita de bolis, mais bolis eu num gostis.")
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    authManager.delegate = self
    title = Constants.APP_NAME
    navigationItem.hidesBackButton = true
    
    tableView.register(UINib(nibName: Constants.CHAT_TABLE_VIEW_NIB_NAME, bundle: nil), forCellReuseIdentifier: Constants.CHAT_TABLE_VIEW_REUSABLE_CELL)
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
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CHAT_TABLE_VIEW_REUSABLE_CELL, for: indexPath) as! ChatMessageCell
    cell.messageLabel.text = messages[indexPath.row].body
    return cell
  }
}
