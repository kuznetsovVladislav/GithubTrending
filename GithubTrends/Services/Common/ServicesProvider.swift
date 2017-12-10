//
//  ServicesProvider.swift
//  GithubTrends
//
//  Created by Vlad Kuznetsov on 23.11.17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation

final class ServicesProvider: AuthServiceProvider, TrendingsServiceProvider, UserServiceProvider {
    
    private let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
    
    var authService: AuthServiceProtocol {
        return AuthService(apiService: apiService)
    }
    
    var trendsService: TrendingsServiceProtocol {
        return TrendingsService(apiService: apiService)
    }
    
    var userService: UserServiceProtocol {
        return UserService(apiService: apiService)
    }
}



