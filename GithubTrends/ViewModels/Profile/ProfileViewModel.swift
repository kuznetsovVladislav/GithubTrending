//
//  ProfileViewModel.swift
//  GithubTrends
//
//  Created by Владислав  on 12/9/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

final class ProfileViewModel: ViewModelProtocol {
    
    typealias Services = UserServiceProvider

    struct Actions {
        let logoutAction: Action<(), (), NoError>
    }
    
    struct Input {
        let joinDarkSideSwitchChanged: Signal<Bool, NoError>
        let saveSearchResultsSwitchChanged: Signal<Bool, NoError>
        let logoutButtonPressed: Signal<(), NoError>
    }
    
    struct Output {
        let name: Signal<String, NoError>
        let login: Signal<String, NoError>
        let email: Signal<String, NoError>
        let bio: Signal<String?, NoError>
        let avatar: Signal<URL, NoError>
        let isDarkSideChosed: Property<Bool>
        let error: Signal<BaseError, NoError>
        let shouldReloadInterface: Signal<(), NoError>
    }
    
    private let services: Services
    private let actions: Actions
    
    private lazy var fetchUserAction = Action(execute: services.userService.fetchSelfUser)
    
    init(services: Services, actions: Actions) {
        self.services = services
        self.actions = actions
    }
    
    func transform(_ input: Input) -> Output {
        fetchUserAction.apply().start()
        
        AppTheme.current.side <~ input.joinDarkSideSwitchChanged.map {$0 ? .darkSide : .brightSide}
        actions.logoutAction <~ input.logoutButtonPressed
        
        let nameSignal = fetchUserAction.values.map {$0.name}
        let loginSignal = fetchUserAction.values.map {$0.login}
        let emailSignal = fetchUserAction.values.map {$0.email}
        let bioSignal = fetchUserAction.values.map {$0.bio}
        let avatarSignal = fetchUserAction.values.map {URL(string: $0.avatar)}.skipNil()
        let errorSignal = fetchUserAction.errors
        let shouldReload = fetchUserAction.events.mapToVoid()
        let isDarkSideChosen = Property(AppTheme.current.side.map {$0 == .darkSide})
        
        return Output(
            name: nameSignal,
            login: loginSignal,
            email: emailSignal,
            bio: bioSignal,
            avatar: avatarSignal,
            isDarkSideChosed: isDarkSideChosen,
            error: errorSignal,
            shouldReloadInterface: shouldReload
        )
    }
    
}
