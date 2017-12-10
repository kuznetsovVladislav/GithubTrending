//
//  ManagedTrendingOwner+CoreDataProperties.swift
//  GithubTrends
//
//  Created by Владислав  on 12/9/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//
//

import Foundation
import CoreData


extension ManagedTrendingOwner {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedTrendingOwner> {
        return NSFetchRequest<ManagedTrendingOwner>(entityName: "ManagedTrendingOwner")
    }

    @NSManaged public var id: Int64
    @NSManaged public var login: String?
    @NSManaged public var avatar: String?
    @NSManaged public var htmlUrl: String?
    @NSManaged public var managedTrending: ManagedTrending?

}
