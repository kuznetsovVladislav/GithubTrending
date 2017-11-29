//
//  FetchedResultsDataSourceUpdate.swift
//  GithubTrends
//
//  Created by Владислав  on 30.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation

enum FetchedResultsDataSourceUpdate {
    case insertSections([Int])
    case updateSections([Int])
    case deleteSections([Int])
    
    case insertItems([IndexPath])
    case updateItems([IndexPath])
    case moveItems([(from: IndexPath, to: IndexPath)])
    case deleteItems([IndexPath])
}
