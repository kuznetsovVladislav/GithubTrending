//
//  TrendingViewModel.swift
//  GithubTrends
//
//  Created by Владислав  on 01.12.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa
import Result

final class TrendingViewModel: ViewModelProtocol {
    
    typealias Services = TrendingsServiceProvider
    
    private let services: Services
    
    private let cellViewModels: MutableProperty<[TrendingCellViewModel]> = .init([])
    private let pagination: MutableProperty<Pagination> = .init(Pagination(page: 1, perPage: 20))
    
    private lazy var fetchTrendingsAction = Action(execute: self.services.trendsService.fetchTrendings)
    
    // MARK: - ViewModelProtocol
    
    struct Input {
        let rowSelection: Signal<Int, NoError>
        let willDisplayRowForPagination: Signal<(), NoError>
        let searchBarInput: Signal<String, NoError>
    }

    struct Output {
        let cellViewModels: MutableProperty<[TrendingCellViewModel]>
        let requestCompleted: Signal<(), NoError>
        let isExecuting: Property<Bool>
    }
    
    init(services: Services) {
        self.services = services
    }
    
    func transform(_ input: TrendingViewModel.Input) -> TrendingViewModel.Output {
        let mappedCellsActionSignal = fetchTrendingsAction.values.map {$0.items.map {TrendingCellViewModel(trending: $0)}}
        let mappedPaginationActionSignal = fetchTrendingsAction.values.map {$0.pagination}
        
        cellViewModels <~ mappedCellsActionSignal.producer
        pagination <~ mappedPaginationActionSignal.producer
        
        fetchTrendingsAction.apply((nil, pagination.value, true)).start()
        fetchTrendingsAction <~ input.searchBarInput
            .map {($0, self.pagination.value, true)}
            .debounce(0.3, on: QueueScheduler())
        fetchTrendingsAction <~ input.willDisplayRowForPagination
            .map {(nil, self.pagination.value, true)}
        
        let requestCompleted = fetchTrendingsAction.events.mapToVoid()
        
        return Output(
            cellViewModels: cellViewModels,
            requestCompleted: requestCompleted,
            isExecuting: fetchTrendingsAction.isExecuting
        )
    }
}
