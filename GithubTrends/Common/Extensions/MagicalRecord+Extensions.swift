//
//  MagicalRecord+Extensions.swift
//  GithubTrends
//
//  Created by Владислав  on 27.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation
import MagicalRecord

extension NSManagedObjectContext {
    static var `default`: NSManagedObjectContext {
        return .mr_default()
    }
}
