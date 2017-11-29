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
    func fetchTrendings(for language: Language?) -> SignalProducer<Slice<Trending>, BaseError>
}

class TrendingsService: TrendingsServiceProtocol {
    
    private let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetchLanguages() -> SignalProducer<[Language], BaseError> {
        return .empty
    }
    
    func fetchTrendings(for language: Language?) -> SignalProducer<Slice<Trending>, BaseError> {
        let endpoint = apiService.endpoint(Path.repos)
        let parameters: [String: Any] = [
            "q": "swift",
            "sort": "stars",
            "language": "swift",
            "page": 1,
            "per_page": 5
        ]
        let pagination = Pagination(page: 1, perPage: 5)
        let request = apiService.session.request(endpoint, method: .get, parameters: parameters)
        return request.sliceResponse(pagination: pagination)
    }
}

fileprivate enum Path {
    static let repos: String = "search/repositories"
}
