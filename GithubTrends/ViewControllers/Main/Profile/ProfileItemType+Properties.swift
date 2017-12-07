//
//  ProfileItemType+Properties.swift
//  GithubTrends
//
//  Created by Владислав  on 12/8/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit

extension ProfileSectionType {
    var height: CGFloat {
        switch self {
        case .header:
            return .leastNonzeroMagnitude
        default:
            return 10.0
        }
    }
}

extension ProfileRowType {
    var height: CGFloat {
        switch self {
        case .header:
            return 180.0
        case .colorTheme:
            return 60
        case .saveToStore:
            return 60
        case .logout:
            return 60
        }
    }
    
    var title: String {
        switch self {
        case .colorTheme:
            return "Join the Dark Side"
        case .saveToStore:
            return "Should save search results"
        case .logout:
            return "Logout"
        default:
            return ""
        }
    }
}
