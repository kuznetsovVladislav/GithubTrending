//
//  ApiError.swift
//  GithubTrends
//
//  Created by Владислав  on 23.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit

struct ApiError: LocalizedError {
    let message: String
    private let documentationUrl: String?
    
    var errorDescription: String? {
        return message
    }
    
    init?(json: [String: Any]) {
        if let message = json["message"] as? String {
            self.message = message
            documentationUrl = json["documentation_url"] as? String
        } else {
            return nil
        }
    }
}
