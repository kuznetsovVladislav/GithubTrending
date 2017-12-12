//
//  ManagedUser+CoreDataProperties.swift
//  GithubTrends
//
//  Created by Владислав  on 12/12/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//
//

import Foundation
import CoreData


extension ManagedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedUser> {
        return NSFetchRequest<ManagedUser>(entityName: "ManagedUser")
    }

    @NSManaged public var avatarUrl: String?
    @NSManaged public var bio: String?
    @NSManaged public var email: String?
    @NSManaged public var id: Int64
    @NSManaged public var location: String?
    @NSManaged public var login: String?
    @NSManaged public var name: String?
    @NSManaged public var url: String?
    @NSManaged public var repos: Int64
    @NSManaged public var followers: Int64
    @NSManaged public var following: Int64

}
