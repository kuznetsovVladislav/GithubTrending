//
//  ManagedTrending+CoreDataProperties.swift
//  GithubTrends
//
//  Created by Владислав  on 12/9/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//
//

import Foundation
import CoreData


extension ManagedTrending {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedTrending> {
        return NSFetchRequest<ManagedTrending>(entityName: "ManagedTrending")
    }

    @NSManaged public var createdAt: NSDate?
    @NSManaged public var forksCount: NSNumber?
    @NSManaged public var fullName: String?
    @NSManaged public var id: Int64
    @NSManaged public var language: String?
    @NSManaged public var name: String?
    @NSManaged public var repoDescription: String?
    @NSManaged public var repoUrl: String?
    @NSManaged public var starsCount: NSNumber?
    @NSManaged public var updatedAt: NSDate?
    @NSManaged public var owner: ManagedTrendingOwner?

}
