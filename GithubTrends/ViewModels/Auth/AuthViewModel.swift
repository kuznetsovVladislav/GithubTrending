//
//  AuthViewModel.swift
//  GithubTrends
//
//  Created by Владислав  on 12/9/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

final class AuthViewModel: ViewModelProtocol {

    typealias Services = AuthServiceProvider
    
    struct Actions {
        let authAction: Action<(), (), NoError>
    }
    
    struct Input {
        let authButtonPressed: Signal<(), NoError>
    }
    
    struct Output {
        
    }
    
    private let services: Services
    private let actions: Actions
    
    init(services: Services, actions: Actions) {
        self.services = services
        self.actions = actions
    }
    
    func transform(_ input: Input) -> Output {
        actions.authAction <~ input.authButtonPressed
        return Output()
    }
}
