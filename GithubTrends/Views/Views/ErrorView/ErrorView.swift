//
//  ErrorView.swift
//  GithubTrends
//
//  Created by Владислав  on 12/11/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit

class ErrorView: UIView {

    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageLabel.alpha = 0.0
        messageLabel.text = ""
    }
    
    func show(_ message: String, animated: Bool = false, completion: ((Bool) -> Void)? = nil) {
        messageLabel.text = message
        UIView.animate(withDuration: animated ? 0.2 : 0.0, animations: {
            self.messageLabel.alpha = 1.0
        }, completion: completion)
    }
    
    func hideMessage(animated: Bool = false, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: animated ? 0.2 : 0.0, animations: {
            self.messageLabel.alpha = 0.0
        }, completion: { success in
            self.messageLabel.text = ""
            completion?(success)
        })
    }
}
