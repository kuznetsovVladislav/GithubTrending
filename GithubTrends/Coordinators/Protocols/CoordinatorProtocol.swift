//
//  CoordinatorProtocol.swift
//  GithubTrends
//
//  Created by Vlad Kuznetsov on 23.11.17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa
import Result

protocol CoordinatorProtocol: class {
    var containerController: BaseContainerControllerProtocol { get set }
    var services: ServicesProvider { get }
    var childs: [CoordinatorProtocol] { get set }
    var shouldRemoveFromParent: Signal<(), NoError>? { get set }
    func start()
}

extension CoordinatorProtocol where Self: NSObject {
    func add(child: CoordinatorProtocol) {
        childs.append(child)
        if let shouldRemoveFromParent = child.shouldRemoveFromParent {
            shouldRemoveFromParent.take(during: reactive.lifetime).observeCompleted { [weak self] in
                self?.remove(child: child)
            }
        }
    }
    
    func remove(child: CoordinatorProtocol) {
        childs = childs.filter {$0 !== child}
    }
}
