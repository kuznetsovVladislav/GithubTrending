//
//  AuthService.swift
//  GithubTrends
//
//  Created by Владислав  on 23.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import Alamofire
import ReactiveSwift
import ReactiveCocoa
import Result
import OAuthSwift

protocol AuthServiceProvider {
    var authService: AuthServiceProtocol { get }
}

protocol AuthServiceProtocol: class {
    var isSessionActive: Property<Bool> { get }
    func signIn(email: String, password: String) -> SignalProducer<User, BaseError>
    func signOut() -> SignalProducer<(), NoError>
}

final class AuthService: AuthServiceProtocol {
    
    private let apiService: ApiServiceProtocol
    
    private let _isSessionActive: MutableProperty<Bool> = MutableProperty(false)
    private(set) lazy var isSessionActive: Property<Bool> = Property(_isSessionActive)
    
    private var oauthSwift: OAuth2Swift  {
        return OAuth2Swift(
            consumerKey: AuthServiceConstant.clientId,
            consumerSecret: AuthServiceConstant.clientSecret,
            authorizeUrl: AuthServiceConstant.authUrl,
            responseType: AuthServiceConstant.responseType
        )
    }
    
    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10)) {
            self._isSessionActive.value = true
        }
    }
    
    func signIn(email: String, password: String) -> SignalProducer<User, BaseError> {
        oauthSwift.authorize(withCallbackURL: "git", scope: "user", state: "GITHUB", success: { credential, response, parameters in
            
        }, failure: { error in
            
        })
        
        return .empty
    }
    
    func signOut() -> SignalProducer<(), NoError> {
        return .empty
    }
}

fileprivate enum AuthServiceConstant {
    static let clientId: String = "d516ca163abd466a8e9f"
    static let clientSecret: String = "339b85674af9ebb6c61f429c78721e12b9fc8061"
    static let authUrl: String = "https://github.com/login/oauth/authorize"
    static let responseType: String = "token"
}
