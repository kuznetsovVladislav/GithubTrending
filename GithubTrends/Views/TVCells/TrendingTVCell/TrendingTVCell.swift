//
//  TrendingTVCell.swift
//  GithubTrends
//
//  Created by Владислав  on 01.12.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit

class TrendingTVCell: UITableViewCell {

    @IBOutlet private weak var roundView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var starsCountLabel: UILabel!
    @IBOutlet private weak var branchesCountLabel: UILabel!
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            roundView.backgroundColor = Constant.selectedColor
        } else {
            UIView.animate(withDuration: Constant.selectedAnimationDuration, animations: {
                self.roundView.backgroundColor = .white
            })
        }
    }
    
    func configure(with cellViewModel: TrendingCellViewModel) {
        nameLabel.attributedText = cellViewModel.name
        descriptionLabel.text = cellViewModel.description
        languageLabel.text = cellViewModel.language
        starsCountLabel.text = cellViewModel.starsCount
        branchesCountLabel.text = cellViewModel.forksCount
    }
    
}

fileprivate enum Constant {
    static let selectedColor: UIColor = UIColor(white: 200.0/255.0, alpha: 1.0)
    static let selectedAnimationDuration: TimeInterval = 0.5
}
