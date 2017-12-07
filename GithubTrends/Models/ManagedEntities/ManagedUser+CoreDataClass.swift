//
//  ManagedUser+CoreDataClass.swift
//  GithubTrends
//
//  Created by Владислав  on 30.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ManagedUser)
public final class ManagedUser: NSManagedObject, DomainConvertible {

    var asDomain: User {
        return User(
            id: Int(id)
        )
    }
    
    init(domain: User) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "\(ManagedUser.self)", in: .default)!
        super.init(entity: entityDescription, insertInto: .default)
        id = Int64(domain.id)
    }
    
}
