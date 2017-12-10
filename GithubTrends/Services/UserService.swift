//
//  UserService.swift
//  GithubTrends
//
//  Created by Владислав  on 12/10/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa
import Result

protocol UserServiceProvider {
    var userService: UserServiceProtocol { get }
}

protocol UserServiceProtocol {
    func fetchSelfUser() -> SignalProducer<User, BaseError>
}

final class UserService: UserServiceProtocol {
    
    private let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetchSelfUser() -> SignalProducer<User, BaseError> {
        let endpoint = apiService.endpoint(Endpoint.user(username: "kuznetsovVladislav").path)
        let request = apiService.session.request(endpoint, method: .get)
        return request.singleResponse()
    }
    
}

fileprivate enum Endpoint {
    case selfUser
    case user(username: String)
    
    var path: String {
        switch self {
        case .selfUser:
            return "/user"
        case .user(let username):
            return "/users/\(username)"
        }
    }
}
