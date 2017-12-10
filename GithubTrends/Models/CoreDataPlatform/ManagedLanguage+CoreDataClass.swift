//
//  ManagedLanguage+CoreDataClass.swift
//  GithubTrends
//
//  Created by Владислав  on 30.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ManagedLanguage)
public final class ManagedLanguage: NSManagedObject, DomainConvertible {
    
    var asDomain: Language {
        return Language(
            id: id ?? "",
            name: name ?? ""
        )
    }
    
    init(domain: Language) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "\(ManagedUser.self)", in: .default)!
        super.init(entity: entityDescription, insertInto: .default)
        id = domain.id
        name = domain.name
    }
}
