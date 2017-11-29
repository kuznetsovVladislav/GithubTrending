//
//  User+CoreDataClass.swift
//  GithubTrends
//
//  Created by Владислав  on 23.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//
//

import Foundation
import CoreData
import ObjectMapper
import MagicalRecord


@objc(User)
public class User: NSManagedObject, Mappable {

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    public required init?(map: Map) {
        let context = NSManagedObjectContext.mr_default()
        let entity = NSEntityDescription.entity(forEntityName: "\(User.self)", in: context)
        super.init(entity: entity!, insertInto: context)
        mapping(map: map)
    }
    
    public func mapping(map: Map) {
        
    }
    
}
