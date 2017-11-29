//
//  BaseError.swift
//  GithubTrends
//
//  Created by Владислав  on 23.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit

enum BaseError: LocalizedError, CustomNSError {
    case mapping
    case apiError(ApiError)
    case unknown
}
