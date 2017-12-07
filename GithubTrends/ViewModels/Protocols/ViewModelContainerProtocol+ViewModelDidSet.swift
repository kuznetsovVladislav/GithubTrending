//
//  ViewModelContainerProtocol+ViewModelDidSet.swift
//  GithubTrends
//
//  Created by Vlad Kuznetsov on 23.11.17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa
import Result

extension ViewModelContainerProtocol where Self: UIViewController {
    
    fileprivate var didLoadTrigger: SignalProducer<(), NoError> {
            return reactive
                .trigger(for: #selector(viewDidLoad))
                .take(first: 1)
                .observe(on: UIScheduler())
                .take(during: reactive.lifetime)
                .producer
    }
    
    var viewModel: ViewModel {
        get {
            return getAssociatedObject(for: ViewModelContainerKey.viewModel, sourceObject: self)!
        }
        set {
            let token = Lifetime.Token()
            setAssociated(value: token, sourceObject: self, for: ViewModelContainerKey.lifetimeToken, policy: .retain)
            setAssociated(value: newValue, sourceObject: self, for: ViewModelContainerKey.viewModel, policy: .retain)
            
            reactive.makeBindingTarget { (viewModel, _: Void) in
                viewModel.didSet(newValue, for: Lifetime(token))
            } <~ didLoadTrigger
        }
    }
}

fileprivate enum ViewModelContainerKey {
    static let viewModel: String = "ViewModelKey"
    static let lifetimeToken: String = "LifetimeTokenKey"
}
