//
//  TrendingOwner.swift
//  GithubTrends
//
//  Created by Владислав  on 12/7/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation

struct TrendingOwner: Codable {
    let id: Int
    let login: String
    let avatar: String
    let htmlUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case login = "login"
        case avatar = "avatar_url"
        case htmlUrl = "html_url"
    }
}

