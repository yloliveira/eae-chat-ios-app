//
//  ChatManager.swift
//  Eae Chat
//
//  Created by Yan Oliveira on 11/10/22.
//  Copyright © 2022 yloliveira. All rights reserved.
//

import Foundation

protocol ChatManager {
  var delegate: ChatManagerDelegate? { get }
  func sendMessage(message: ChatMessage) -> Void
  func listMessages() -> Void
}

protocol ChatManagerDelegate {
  func chatManagerDidSendMessage(message: ChatMessage) -> Void
  func chatManagerDidListMessages(messages: [ChatMessage]) -> Void
  func chatManagerDidFailWithError(_ error: Error) -> Void
}
