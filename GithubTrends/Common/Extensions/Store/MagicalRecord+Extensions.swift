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

protocol ManagedObjectFoundable {}
extension NSManagedObject: ManagedObjectFoundable {}

extension ManagedObjectFoundable where Self: NSManagedObject {
    static func findAll() -> [Self] {
        return mr_findAll() as? [Self] ?? []
    }
}
