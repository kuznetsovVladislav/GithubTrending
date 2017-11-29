//
//  CollectionDataSource.swift
//  GithubTrends
//
//  Created by Владислав  on 30.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation

protocol CollectionDataSource {
    associatedtype Item
    
    var numberOfSections: Int { get }
    var totalItemsNumber: Int { get }
    func numberOfItems(inSection section: Int) -> Int
    func item(at indexPath: IndexPath) -> Item
}

extension Array: CollectionDataSource {
    var numberOfSections: Int {
        return 1
    }
    
    var totalItemsNumber: Int {
        return count
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        return count
    }
    
    func item(at indexPath: IndexPath) -> Element {
        return self[indexPath.item]
    }
}
