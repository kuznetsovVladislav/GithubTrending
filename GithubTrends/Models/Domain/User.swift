//
//  User.swift
//  GithubTrends
//
//  Created by Владислав  on 30.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    let login: String
    let name: String
    let email: String
    let location: String
    let avatar: String
    let url: String
    let bio: String?
    var repos: Int
    var followers: Int
    var following: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case login = "login"
        case name = "name"
        case email = "email"
        case location = "location"
        case avatar = "avatar_url"
        case url = "html_url"
        case bio = "bio"
        case repos = "public_repos"
        case followers = "followers"
        case following = "following"
    }
}

