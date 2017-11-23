//
//  CoordinatorProtocol.swift
//  GithubTrends
//
//  Created by Vlad Kuznetsov on 23.11.17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation

protocol CoordinatorProtocol: class {
    var containerController: BaseContainerControllerProtocol { get set }
    var childs: [CoordinatorProtocol] { get set }
    var services: ServicesProvider { get }
    func start()
}

extension CoordinatorProtocol {
    
    func add(child: CoordinatorProtocol) {
        childs.append(child)
    }
    
//    @discardableResult
    func remove(child: CoordinatorProtocol)/* -> CoordinatorProtocol*/ {
        
    }
}
