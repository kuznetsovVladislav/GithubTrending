//
//  ManagedTrendingOwner+CoreDataClass.swift
//  GithubTrends
//
//  Created by Владислав  on 12/9/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ManagedTrendingOwner)
public final class ManagedTrendingOwner: NSManagedObject, DomainConvertible {

    var asDomain: TrendingOwner {
        return TrendingOwner(
            id: Int(id),
            login: login ?? "",
            avatar: avatar ?? "",
            htmlUrl: htmlUrl ?? ""
        )
    }
    
    init(domain: TrendingOwner) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "\(ManagedTrendingOwner.self)", in: .default)!
        super.init(entity: entityDescription, insertInto: .default)
        id = Int64(domain.id)
        login = domain.login
        avatar = domain.avatar
        htmlUrl = domain.htmlUrl
    }
    
}
