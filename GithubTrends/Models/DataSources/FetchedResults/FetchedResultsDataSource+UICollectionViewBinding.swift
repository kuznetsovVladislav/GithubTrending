//
//  FetchedResultsDataSource+UICollectionViewBinding.swift
//  GithubTrends
//
//  Created by Владислав  on 30.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

extension Reactive where Base: UICollectionView {
    
    func fetchedResultsDataSource<T, CellType: UICollectionViewCell>(configure: @escaping FetchResultsConfigureBlock<T, UICollectionView, CellType>) -> BindingTarget<FetchedResultsDataSource<T>.UpdateEvent>
    {
        return makeBindingTarget { `self`, event in
            self.performBatchUpdates(event, animated: true, configure: configure)
        }
    }
}

extension UICollectionView {
    
    func performBatchUpdates<T, CellType: UICollectionViewCell>(
        _ event: FetchedResultsDataSource<T>.UpdateEvent,
        animated: Bool = true,
        configure: @escaping FetchResultsConfigureBlock<T, UICollectionView, CellType>)
    {
        performBatchUpdates({
            for update in event.updates {
                switch update {
                case .insertItems(let items):
                    self.insertItems(at: items)
                case .updateItems(let items):
                    for indexPath in items {
                        if let cell = self.cellForItem(at: indexPath) as? CellType {
                            configure(event.dataSource, self, cell, indexPath)
                        }
                    }
                case .moveItems(let items):
                    items.forEach { self.moveItem(at: $0.from, to: $0.to) }
                case .deleteItems(let items):
                    self.deleteItems(at: items)
                case .insertSections(let sections):
                    self.insertSections(IndexSet(sections))
                case .updateSections(let sections):
                    self.reloadSections(IndexSet(sections))
                case .deleteSections(let sections):
                    self.deleteSections(IndexSet(sections))
                }
            }
        }, completion: nil)
    }
}
