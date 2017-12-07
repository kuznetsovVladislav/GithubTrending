//
//  FetchedResultsDataSource+Reactive.swift
//  GithubTrends
//
//  Created by Владислав  on 30.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

extension Reactive where Base: UITableView {
    
    func fetchedResultsDataSource<T, CellType: UITableViewCell>(animationType: UITableViewRowAnimation = .fade, configure: @escaping FetchResultsConfigureBlock<T, UITableView, CellType>) -> BindingTarget<FetchedResultsDataSource<T>.UpdateEvent>
    {
        return makeBindingTarget { `self`, event in
            self.performBatchUpdates(event, animated: true, animationType: animationType, configure: configure)
        }
    }
}

extension UITableView {
    
    func performBatchUpdates<T, CellType: UITableViewCell>(
        _ event: FetchedResultsDataSource<T>.UpdateEvent,
        animated: Bool = true,
        animationType: UITableViewRowAnimation,
        configure: FetchResultsConfigureBlock<T, UITableView, CellType>)
    {
        beginUpdates()
        for update in event.updates {
            switch update {
            case .insertItems(let items):
                self.insertRows(at: items, with: animationType)
            case .updateItems(let items):
                for indexPath in items {
                    if let cell = cellForRow(at: indexPath) as? CellType {
                        configure(event.dataSource, self, cell, indexPath)
                    }
                }
            case .moveItems(let items):
                items.forEach {self.moveRow(at: $0.from, to: $0.to)}
            case .deleteItems(let items):
                self.deleteRows(at: items, with: animationType)
            case .insertSections(let sections):
                self.insertSections(IndexSet(sections), with: animationType)
            case .updateSections(let sections):
                self.reloadSections(IndexSet(sections), with: animationType)
            case .deleteSections(let sections):
                self.deleteSections(IndexSet(sections), with: animationType)
            }
        }
        endUpdates()
    }
    
}
