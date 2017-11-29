//
//  BaseCoordinator.swift
//  GithubTrends
//
//  Created by Владислав  on 23.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

class BaseCoordinator: NSObject {
    
    // MARK: - Lifecycle
    
    override init() {
        super.init()
        print("\(self) \(#function)")
    }
    
    deinit {
        print("\(self) \(#function)")
    }
}
