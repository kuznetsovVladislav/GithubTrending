//
//  Pagination.swift
//  GithubTrends
//
//  Created by Владислав  on 27.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation

struct Pagination {
    let page: Int
    let perPage: Int
    
    var next: Pagination {
        return Pagination(page: page + 1, perPage: perPage)
    }
}
