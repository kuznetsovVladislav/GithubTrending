//
//  DomainConvertible.swift
//  GithubTrends
//
//  Created by Владислав  on 30.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation
import CoreData

protocol DomainConvertible {
    associatedtype Domain
    
    init(domain: Domain)
    var asDomain: Domain { get }
}
