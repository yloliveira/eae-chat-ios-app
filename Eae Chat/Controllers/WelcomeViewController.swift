//
//  WelcomeViewController.swift
//  Eae Chat
//
//  Created by Yan Oliveira on 01/10/2022.
//  Copyright © 2019 yloliveira. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateTitle()
    }
    
    
    private func animateTitle() {
        let title = "💬 Eae"
        titleLabel.text = ""
        var index = 0.0
        
        for letter in title {
            Timer.scheduledTimer(withTimeInterval: 0.2 * index, repeats: false) { timer in
                self.titleLabel.text?.append(letter)
            }
            index += 1
        }
    }
}
