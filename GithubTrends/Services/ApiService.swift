//
//  ApiService.swift
//  GithubTrends
//
//  Created by Владислав  on 23.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import Alamofire

protocol ApiServiceProtocol {
    var session: SessionManager { get }
    func endpoint(_ path: String) -> String
}

final class ApiService: ApiServiceProtocol {
    
    private let configuration: Configuration
    let session: SessionManager
    
    var baseUrl: String {
        return "https://api.github.com/"
    }
    
    init(configuration: Configuration) {
        self.configuration = configuration
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        session = ApiSessionManager(configuration: sessionConfiguration)
    }
    
    func endpoint(_ path: String) -> String {
        return baseUrl + path
    }
}
