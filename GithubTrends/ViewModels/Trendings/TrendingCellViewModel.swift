//
//  TrendingCellViewModel.swift
//  GithubTrends
//
//  Created by Владислав  on 01.12.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit

final class TrendingCellViewModel {
    let name: NSAttributedString
    let description: String
    let language: String
    let starsCount: String
    let forksCount: String

    init(trending: Trending) {
        let attributedName = NSMutableAttributedString()
        let concatedName = trending.owner.login + " / "
        attributedName.append(NSAttributedString(string: concatedName, attributes: TrendingCellViewModel.ownerAttributes))
        attributedName.append(NSAttributedString(string: trending.name, attributes: TrendingCellViewModel.repoAttributes))
        
        name = attributedName
        description = trending.description
        language = trending.language ?? "Unknown"
        starsCount = String(describing: trending.starsCount)
        forksCount = String(describing: trending.forksCount)
    }
    
    private static var ownerAttributes: [NSAttributedStringKey: Any] {
        return [.font: UIFont.helveticaNeue(withSize: 17.0, weight: .regular)]
    }
    
    private static var repoAttributes: [NSAttributedStringKey: Any] {
        return [.font: UIFont.helveticaNeue(withSize: 17.0, weight: .bold)]
    }
}

