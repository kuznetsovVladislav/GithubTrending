//
//  LabelTVCell.swift
//  GithubTrends
//
//  Created by Владислав  on 12/8/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit

class LabelTVCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    var title: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = title
    }
}
