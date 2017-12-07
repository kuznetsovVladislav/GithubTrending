//
//  ManagedLanguage+CoreDataProperties.swift
//  GithubTrends
//
//  Created by Владислав  on 30.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//
//

import Foundation
import CoreData


extension ManagedLanguage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedLanguage> {
        return NSFetchRequest<ManagedLanguage>(entityName: "ManagedLanguage")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?

}
