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
    }
    
    func showMessage(animated: Bool = false, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: animated ? 0.2 : 0.0, animations: {
            self.messageLabel.alpha = 1.0
        }, completion: completion)
    }
    
    func hideMessage(animated: Bool = false, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: animated ? 0.2 : 0.0, animations: {
            self.messageLabel.alpha = 0.0
        }, completion: completion)
    }
}
