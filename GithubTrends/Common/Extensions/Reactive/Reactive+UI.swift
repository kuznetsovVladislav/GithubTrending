//
//  Reactive+UI.swift
//  GithubTrends
//
//  Created by Владислав  on 01.12.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result
import UIScrollView_InfiniteScroll

extension Reactive where Base: UIViewController {
    var shouldShowNetworkActivity: BindingTarget<Bool> {
        return makeBindingTarget { _, shouldShow in
            UIApplication.shared.isNetworkActivityIndicatorVisible = shouldShow
        }
    }
}

extension Reactive where Base: NSObject & UITableViewDelegate {
    var rowSelection: Signal<IndexPath, NoError> {
        let selector = #selector(base.tableView(_:didSelectRowAt:))
        return handle(selector: selector)
    }
    
    var rowDeselection: Signal<IndexPath, NoError> {
        let selector = #selector(base.tableView(_:didDeselectRowAt:))
        return handle(selector: selector)
    }
    
    var rowDisplayingBeginning: Signal<IndexPath, NoError> {
        let selector = #selector(base.tableView(_:willDisplay:forRowAt:))
        return handle(selector: selector)
    }
    
    private func handle(selector: Selector) -> Signal<IndexPath, NoError> {
        return signal(for: selector)
            .attemptMap { (values) -> Result<IndexPath?, NoError> in
                let indexPath = (values.last as? IndexPath)
                return Result(value: indexPath)
            }
            .skipNil()
    }
}

extension Reactive where Base: NSObject & UICollectionViewDelegate {
    var itemSelection: Signal<IndexPath, NoError> {
        let selector = #selector(base.collectionView(_:didSelectItemAt:))
        return handle(selector: selector)
    }
    
    var itemDeselection: Signal<IndexPath, NoError> {
        let selector = #selector(base.collectionView(_:didDeselectItemAt:))
        return handle(selector: selector)
    }
    
    var itemDisplayingBeginning: Signal<IndexPath, NoError> {
        let selector = #selector(base.collectionView(_:willDisplay:forItemAt:))
        return handle(selector: selector)
    }
    
    private func handle(selector: Selector) -> Signal<IndexPath, NoError> {
        return signal(for: selector)
            .attemptMap { (values) -> Result<IndexPath?, NoError> in
                let indexPath = (values.last as? IndexPath)
                return Result(value: indexPath)
            }
            .skipNil()
    }
}

