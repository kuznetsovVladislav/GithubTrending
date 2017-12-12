//
//  ArrayTableViewDataSource.swift
//  GithubTrends
//
//  Created by Владислав  on 12/12/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

final class ArrayTableViewDataSource<T>: NSObject, UITableViewDataSource {

    typealias CellFactory = (UITableView, IndexPath, T) -> UITableViewCell
    
    // MARK: - Properties & init
    
    let cellFactory: CellFactory
    private var items: [T] = []
    
    init(cellFactory: @escaping CellFactory) {
        self.cellFactory = cellFactory
    }
    
    // MARK: - Methods
    
    func update(items: [T]) {
        self.items = items
    }
    
    func item(at indexPath: IndexPath) -> T {
        return items[indexPath.row]
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellFactory(tableView, indexPath, item(at: indexPath))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}

// MARK: - ReactiveTableViewDataSource
extension ArrayTableViewDataSource: ReactiveTableViewDataSource {
    func tableView(_ tableView: UITableView, observedEvent: Signal<[T], NoError>.Event) {
        switch observedEvent {
        case .value(let value):
            update(items: value)
            tableView.reloadData()
        case .failed(let error):
            assertionFailure("Bind error: \(error)")
        default:
            break
        }
    }
}

// MARK: - Reactive Items
extension UITableView {
    func reactiveItems
        <DataSource: ReactiveTableViewDataSource & UITableViewDataSource,
        Signal: SignalProtocol>
        (dataSource: DataSource) -> (Signal) -> Disposable?
        where Signal.Error == NoError, Signal.Value == DataSource.Element
    {
        return { source in
            self.dataSource = dataSource
            return source.signal.observe { [weak self] event in
                guard let `self` = self else { return }
                dataSource.tableView(self, observedEvent: event)
            }
        }
    }
    
    func reactiveItems
        <DataSource: ReactiveTableViewDataSource & UITableViewDataSource,
        SignalProducer: SignalProducerProtocol>
        (dataSource: DataSource) -> (SignalProducer) -> Disposable?
        where SignalProducer.Error == NoError, SignalProducer.Value == DataSource.Element
    {
        return { source in
            self.dataSource = dataSource
            return source.producer.start { [weak self] event in
                guard let `self` = self else { return }
                dataSource.tableView(self, observedEvent: event)
            }
        }
    }
}

// MARK: - Custom binding
extension SignalProducerConvertible {
    @discardableResult
    func bind<R>(with: (SignalProducer<Value, Error>) -> R) -> R {
        return with(self.producer)
    }
}

extension SignalProtocol {
    @discardableResult
    func bind<R>(with: (Signal<Value, Error>) -> R) -> R {
        return with(self.signal)
    }
}
