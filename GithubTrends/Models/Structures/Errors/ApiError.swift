//
//  ApiError.swift
//  GithubTrends
//
//  Created by Владислав  on 23.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit

struct ApiError: LocalizedError {
    let code: Int
    let message: String
    let errors: [[String: String]]
    
    var errorDescription: String? {
        return message
    }
    
//    init(json: [String: Any]) {
//        message = json["message"] as? String ?? ""
//        if let errors = json["errors"] as? [[String: String]] {
//            self.errors = errors
//        }
//    }
}
