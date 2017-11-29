//
//  Slice.swift
//  GithubTrends
//
//  Created by Владислав  on 28.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import ObjectMapper

struct Slice<Item: Codable> {
    var items: [Item]
    var total: Int
    var pagination: Pagination
    
    static var empty: Slice {
        return Slice(items: [], total: 0, pagination: Pagination(page: 1, perPage: 0))
    }
    
    func item(at index: Int) -> Item? {
        return items[safe: index]
    }
    
    mutating func fill(with slice: Slice<Item>) {
        items.append(contentsOf: slice.items)
        total = slice.total
        pagination = slice.pagination
    }
    
    
}
