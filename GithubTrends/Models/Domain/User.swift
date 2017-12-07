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
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}
