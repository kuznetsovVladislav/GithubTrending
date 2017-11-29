//
//  Trending.swift
//  GithubTrends
//
//  Created by Владислав  on 29.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import ObjectMapper

struct Trending: Codable {
    let id: Int
    let name: String
    let fullName: String
    let forksCount: Int
    let starsCount: Int
    let createdAt: String
    let updatedAt: String
    let language: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case fullName = "full_name"
        case forksCount = "forks_count"
        case starsCount = "stargazers_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case language = "language"
        case url = "url"
    }
}
