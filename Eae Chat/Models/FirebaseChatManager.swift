//
//  FirebaseChatManager.swift
//  Eae Chat
//
//  Created by Yan Oliveira on 11/10/22.
//  Copyright © 2022 yloliveira. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct FirebaseChatManager: ChatManager {
  var delegate: ChatManagerDelegate?
  
  func sendMessage(message: ChatMessage) {
    let db = Firestore.firestore()
    db.collection(Constants.MESSAGES_COLLECTION_NAME).addDocument(data: [
      Constants.MESSAGE_SENDER_FIELD_NAME: message.sender,
      Constants.MESSAGE_BODY_FIELD_NAME: message.body
    ]) { error in
      if let e = error {
        delegate?.chatManagerDidFailWithError(e)
      } else {
        delegate?.chatManagerDidSendMessage(message: message)
      }
    }
  }
}
