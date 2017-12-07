//
//  ReusableViewModelContainerProtocol+ViewModelDidSet.swift
//  GithubTrends
//
//  Created by Vlad Kuznetsov on 23.11.17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation
import Foundation
import ReactiveSwift
import ReactiveCocoa
import Result

extension ReusableViewModelContainerProtocol where Self: NSObject {
    
    fileprivate var didLoadTrigger: SignalProducer<(), NoError> {
        if self is UIViewController {
            return reactive
                .trigger(for: #selector(UIViewController.viewDidLoad))
                .take(first: 1)
                .observe(on: UIScheduler())
                .take(during: reactive.lifetime)
                .producer
        } else {
            return .init(value: ())
        }
    }
    
    var viewModel: ViewModel? {
        get {
            return objc_getAssociatedObject(self, ViewModelContainerKey.viewModel) as? Self.ViewModel
        }
        set {
            objc_setAssociatedObject(self, ViewModelContainerKey.lifetimeToken, nil, .OBJC_ASSOCIATION_RETAIN)
            objc_setAssociatedObject(self, ViewModelContainerKey.lifetimeToken, newValue, .OBJC_ASSOCIATION_RETAIN)
            
            if let newValue = newValue {
                let token = Lifetime.Token()
                objc_setAssociatedObject(self, ViewModelContainerKey.lifetimeToken, token, .OBJC_ASSOCIATION_RETAIN)
                reactive.makeBindingTarget { (viewModel, _: Void) in
                    viewModel.didSet(newValue, for: Lifetime(token))
                } <~ didLoadTrigger
            }
        }
    }
}

fileprivate enum ViewModelContainerKey {
    static let viewModel: String = "ReusableViewModelKey"
    static let lifetimeToken: String = "ReusableLifetimeTokenKey"
}
