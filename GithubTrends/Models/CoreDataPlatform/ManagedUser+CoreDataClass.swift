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
            id: Int(id),
            login: login ?? "",
            name: name ?? "",
            email: email ?? "",
            location: location ?? "",
            avatar: avatarUrl ?? "",
            url: url ?? "",
            bio: bio,
            repos: Int(repos),
            followers: Int(followers),
            following: Int(following)
        )
    }
    
    init(domain: User) {
        let entityDescription = NSEntityDescription.entity(forEntityName: "\(ManagedUser.self)", in: .default)!
        super.init(entity: entityDescription, insertInto: .default)
        id = Int64(domain.id)
        login = domain.login
        name = domain.name
        email = domain.email
        location = domain.location
        avatarUrl = domain.avatar
        url = domain.url
        bio = domain.bio
        repos = Int64(domain.repos)
        followers = Int64(domain.followers)
        following = Int64(domain.following)
    }    
}

