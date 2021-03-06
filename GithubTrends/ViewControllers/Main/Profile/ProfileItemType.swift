//
//  ProfileItemType.swift
//  GithubTrends
//
//  Created by Владислав  on 12/7/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation

enum ProfileSectionType {
    case header
    case settings
    case logout
}

enum ProfileRowType {
    case header
    case colorTheme
    case saveToStore
    case logout
}

struct ProfileSection: Equatable {
    let type: ProfileSectionType
    let rows: [ProfileRowType]
    
    static func ==(lhs: ProfileSection, rhs: ProfileSection) -> Bool {
        return lhs.type == rhs.type && lhs.rows == rhs.rows
    }
}
