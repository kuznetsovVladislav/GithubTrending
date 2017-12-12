//
//  TrendsService.swift
//  GithubTrends
//
//  Created by Владислав  on 27.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
import Alamofire

protocol TrendingsServiceProvider {
    var trendsService: TrendingsServiceProtocol { get }
}

protocol TrendingsServiceProtocol {
    func fetchLanguages() -> SignalProducer<[Language], BaseError>
    func fetchTrendings(for language: String?, pagination: Pagination, savingToStore: Bool) -> SignalProducer<Slice<Trending>, BaseError>
}

final class TrendingsService: TrendingsServiceProtocol {
    
    private let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetchLanguages() -> SignalProducer<[Language], BaseError> {
        return SignalProducer { observer, disposable in
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500), execute: {
                var languages: [Language] = []
                for _ in 1 ... 5 {
                    let id = UUID().uuidString
                    languages.append(Language(id: UUID().uuidString, name: "\(id) Language"))
                }
                observer.send(value: languages)
                observer.sendCompleted()
            })
        }
    }
    
    @discardableResult
    func fetchTrendings(for language: String?, pagination: Pagination, savingToStore: Bool) -> SignalProducer<Slice<Trending>, BaseError> {
        let endpoint = apiService.endpoint(Path.repos)
        let parameters: [String: Any] = [
            "q": "\(language?.nilIfEmpty ?? "All")",
            "sort": "stars",
            "language": "\(language ?? "")",
            "page": pagination.page,
            "per_page": pagination.perPage
        ]
        let request = apiService.session.request(endpoint, method: .get, parameters: parameters)
        return request
            .sliceResponse(pagination: pagination)
            .on(value: { slice in
                self.saveTrendingSliceToStore(slice)
            })
    }
    
    private func saveTrendingSliceToStore(_ trendingSlice: Slice<Trending>) {
//        trendingSlice.items.forEach {
//            StoreService().save(domain: $0, toStoreAs: ManagedTrending.self).start()
//            let managedTrending = ManagedTrending(domain: $0)
//            print()
//        }
    }
}

fileprivate enum Path {
    static let repos: String = "search/repositories"
}
