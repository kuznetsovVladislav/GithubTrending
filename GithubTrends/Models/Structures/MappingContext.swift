//
//  MappingContext.swift
//  GithubTrends
//
//  Created by Владислав  on 28.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import ObjectMapper
import CoreData

struct Context: MapContext {
    let managedObjectContext: NSManagedObjectContext
}
