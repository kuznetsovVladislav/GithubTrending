//
//  BaseError.swift
//  GithubTrends
//
//  Created by Владислав  on 23.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit

enum BaseError: LocalizedError, CustomNSError {
    case apiError(ApiError)
    case mapping
	case storeError(Error)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .apiError(let error):
            return error.message
        case .mapping:
            return "[INTERNAL] Mapping Error"
        case .storeError(let error):
            return "[INTERNAL] Store Error: \(error.localizedDescription)"
        case .unknown:
            return "Oops! Something went wrong. Try again later"
        }
    }
}
