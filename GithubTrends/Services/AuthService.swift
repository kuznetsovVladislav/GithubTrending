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
    func signIn() -> SignalProducer<User, BaseError>
    func signOut() -> SignalProducer<(), NoError>
    func fetchAuthenticatedUser() -> SignalProducer<User, BaseError>
}

final class AuthService: AuthServiceProtocol {
    
    private let apiService: ApiServiceProtocol
    
    private let _isSessionActive: MutableProperty<Bool> = MutableProperty(true)
    private(set) lazy var isSessionActive: Property<Bool> = Property(_isSessionActive)
    
    private var oauthSwift: OAuth2Swift  {
        return OAuth2Swift(
            consumerKey: AuthServiceConstant.clientId,
            consumerSecret: AuthServiceConstant.clientSecret,
            authorizeUrl: AuthServiceConstant.authUrl,
            accessTokenUrl: AuthServiceConstant.accessTokenUrl,
            responseType: AuthServiceConstant.responseType
        )
    }
    
    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
    
    func signIn() -> SignalProducer<User, BaseError> {
        let webViewController = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
//        controller.present(webViewController, animated: true, completion: nil)
        oauthSwift.authorizeURLHandler = webViewController
        let state = UUID().uuidString
        oauthSwift.authorize(withCallbackURL: AuthServiceConstant.callbackUrl, scope: "user, repo", state: state, success: { credential, response, parameters in
            print()
        }, failure: { error in
            print()
        })
        
        return .empty
    }
    
    func signOut() -> SignalProducer<(), NoError> {
        return .empty
    }
    
    func fetchAuthenticatedUser() -> SignalProducer<User, BaseError> {
        return .empty
    }
}

fileprivate enum AuthServiceConstant {
    static let clientId: 		String = "d516ca163abd466a8e9f"
    static let clientSecret: 	String = "339b85674af9ebb6c61f429c78721e12b9fc8061"
    
    static let authUrl: 		String = "https://github.com/login/oauth/authorize"
    static let accessTokenUrl: 	String = "https://github.com/login/oauth/access_token"
    static let callbackUrl: 	String = "https://github.com/app-github-trends"
    
    static let responseType: 	String = "code"
    
}
