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

extension ViewModelContainerProtocol where Self: NSObject {
    
    fileprivate var didLoadTrigger: SignalProducer<(), NoError> {
        if self is UIViewController {
            return reactive
                .trigger(for: #selector(UIViewController.viewDidLoad))
                .take(first: 1)
                .observe(on: UIScheduler())
                .take(during: reactive.lifetime)
                .producer
        } else if self is UIView {
            return reactive
                .trigger(for: #selector(UIView.awakeFromNib))
                .take(first: 1)
                .observe(on: UIScheduler())
                .take(during: reactive.lifetime)
                .producer
        } else {
            return .init(value: ())
        }
    }
    
    var viewModel: ViewModel {
        get {
            return getAssociatedObject(for: &ViewModelContainerAssociationKey.viewModel)!
        }
        set {
            let token = Lifetime.Token()
            setAssociated(object: token, for: &ViewModelContainerAssociationKey.lifetimeToken)
            setAssociated(object: newValue, for: &ViewModelContainerAssociationKey.viewModel)
            reactive.makeBindingTarget { viewModel, _ in
                viewModel.didSet(newValue, for: Lifetime(token))
            } <~ didLoadTrigger
        }
    }
}

fileprivate enum ViewModelContainerAssociationKey {
    static var viewModel: String = "ViewModelKey"
    static var lifetimeToken: String = "LifetimeTokenKey"
}
