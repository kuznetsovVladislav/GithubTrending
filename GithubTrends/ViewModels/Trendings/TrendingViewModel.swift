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
    typealias FetchAction = Action<(String?, Pagination, Bool), Slice<Trending>, BaseError>
    
    private let services: Services
    private let pagination: MutableProperty<Pagination> = .init(.start)
    private let cellViewModels: MutableProperty<[TrendingCellViewModel]> = .init([])
    
    private lazy var fetchNextTrending = Action(execute: services.trendsService.fetchTrendings)
    private lazy var reloadTrending = Action(execute: services.trendsService.fetchTrendings)
    
    // MARK: - ViewModelProtocol
    
    struct Input {
        let retryLoading: Signal<(), NoError>
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
        let nextTrendingViewModels = trendingViewModels(performing: fetchNextTrending)
        let reloadedTrendingViewModels = trendingViewModels(performing: reloadTrending)
        
        let nextTrendingPagintion = pagination(performing: fetchNextTrending)
        let reloadedTrendingPagination = pagination(performing: reloadTrending)
        
        cellViewModels.bind(appending: nextTrendingViewModels.producer)
        cellViewModels <~ reloadedTrendingViewModels.producer
        pagination <~ nextTrendingPagintion.producer
        pagination <~ reloadedTrendingPagination.producer
        
        fetchNextTrending.apply((nil, pagination.value, true)).start()
        fetchNextTrending <~ input.willDisplayRowForPagination
            .map {(nil, self.pagination.value.next, true)}
        reloadTrending <~ input.searchBarInput
            .map {($0, .start, true)}
            .debounce(0.3, on: QueueScheduler())
        reloadTrending <~ input.retryLoading
            .map({(nil, .start, true)})
        
        let requestCompleted = Signal.merge(fetchNextTrending.events, reloadTrending.events).mapToVoid()
        let isExecuting = Property.combineLatest(fetchNextTrending.isExecuting, reloadTrending.isExecuting).map({$0 || $1})
        
        return Output(
            cellViewModels: cellViewModels,
            requestCompleted: requestCompleted,
            isExecuting: isExecuting
        )
    }
    
    private func trendingViewModels(performing action: FetchAction) -> Signal<[TrendingCellViewModel], NoError> {
        return action.values.map {$0.items.map {TrendingCellViewModel(trending: $0)}}
    }
    
    private func pagination(performing action: FetchAction) -> Signal<Pagination, NoError> {
        return action.values.map {$0.pagination}
    }
}
