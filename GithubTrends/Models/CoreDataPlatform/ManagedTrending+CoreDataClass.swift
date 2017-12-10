//
//  ManagedTrending+CoreDataClass.swift
//  GithubTrends
//
//  Created by Владислав  on 29.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//
//

import Foundation
import CoreData
import MagicalRecord

@objc(ManagedTrending)
public final class ManagedTrending: NSManagedObject, DomainConvertible {

    var asDomain: Trending {
        return Trending(
            id: Int(id),
            name: name ?? "",
            description: "",
            fullName: fullName ?? "",
            forksCount: forksCount?.intValue ?? 0,
            starsCount: starsCount?.intValue ?? 0,
            createdAt: "",
            updatedAt: "",
            language: language,
            url: repoUrl,
            owner: owner!.asDomain
        )
    }

    init(domain: Trending) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "\(ManagedTrending.self)", in: .default)!
        super.init(entity: entityDescription, insertInto: .default)
        id = Int64(domain.id)
        name = domain.name
        fullName = domain.fullName
        forksCount = NSNumber(integerLiteral: domain.forksCount)
        starsCount = NSNumber(integerLiteral: domain.starsCount)
        createdAt = NSDate()
        updatedAt = NSDate()
        language = domain.language
        repoUrl = domain.url
        owner = ManagedTrendingOwner(domain: domain.owner)
    }
}
