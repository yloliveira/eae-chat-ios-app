//
//  ChatMessageCell.swift
//  Eae Chat
//
//  Created by Yan Oliveira on 06/10/22.
//  Copyright © 2022 yloliveira. All rights reserved.
//

import UIKit

class ChatMessageCell: UITableViewCell {
  @IBOutlet weak var messageBubble: UIView!
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var senderLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var messageBubbleTrailingConstraint: NSLayoutConstraint!
  @IBOutlet weak var messageBubbleLeadingConstraint: NSLayoutConstraint!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    messageBubble.layer.cornerRadius = 10
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}
