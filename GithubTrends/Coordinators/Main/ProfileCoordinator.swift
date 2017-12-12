//
//  ProfileCoordinator.swift
//  GithubTrends
//
//  Created by Владислав  on 12/10/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

final class ProfileCoordinator: BaseCoordinator, CoordinatorProtocol {
    
    var containerController: BaseContainerControllerProtocol
    var tabBarController: BaseTabBarController
    var services: ServicesProvider
    var childs: [CoordinatorProtocol] = []
    var shouldRemoveFromParent: Signal<(), NoError>?
    
    init(services: ServicesProvider,
         containerController: BaseContainerControllerProtocol,
         tabBarController: BaseTabBarController)
    {
        self.services = services
        self.containerController = containerController
        self.tabBarController = tabBarController
    }
    
    func start() {
        guard
            let profileNavigationController = UIStoryboard(name: "Profile", bundle: nil).instantiateInitialViewController() as? UINavigationController,
            let profileViewController = profileNavigationController.viewControllers.first as? ProfileViewController else {
                return
        }
        let actions = ProfileViewModel.Actions(logoutAction: Action(execute: handleLogout))
        let viewModel = ProfileViewModel(services: services, actions: actions)
        profileViewController.viewModel = viewModel
        if tabBarController.viewControllers != nil {
            tabBarController.viewControllers?.append(profileNavigationController)
        } else {
            tabBarController.viewControllers = [profileNavigationController]
        }
        shouldRemoveFromParent = profileNavigationController.reactive.lifetime.ended.take(during: reactive.lifetime).mapToVoid()
    }
    

    private func handleLogout() -> SignalProducer<(), NoError> {
        return SignalProducer { observer, disposable in
         	self.containerController.changeFlow(to: .auth, animated: true)
            observer.send(value: ())
            observer.sendCompleted()
        }
    }
}
