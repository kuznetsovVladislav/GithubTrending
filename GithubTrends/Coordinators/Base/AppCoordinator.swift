//
//  Coordinator.swift
//  GithubTrends
//
//  Created by Vlad Kuznetsov on 23.11.17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

final class AppCoordinator: BaseCoordinator, CoordinatorProtocol {
    
    var containerController: BaseContainerControllerProtocol
    var services: ServicesProvider
    var childs: [CoordinatorProtocol] = []
    var shouldRemoveFromParent: Signal<(), NoError>? = nil
    
    private var shouldChangeFlowAnimated: Bool = false
    
    init(services: ServicesProvider, containerController: BaseContainerControllerProtocol) {
        self.services = services
        self.containerController = containerController
    }
    
    func start() {
        isSessionActive <~ services.authService.isSessionActive
    }
    
    private func openAuthFlow() {
        let authCoordinator = AuthCoordinator(
            services: services,
            containerController: containerController,
            shouldChangeFlowAnimated: shouldChangeFlowAnimated
        )
        authCoordinator.start()
        add(child: authCoordinator)
    }
    
    private func openMainFlow() {
        let tabBarCoordinator = TabBarCoordinator(
            services: services,
            containerController: containerController,
            shouldChangeFlowAnimated: shouldChangeFlowAnimated
        )
        tabBarCoordinator.start()
        add(child: tabBarCoordinator)
    }
    
    private var isSessionActive: BindingTarget<Bool> {
        return BindingTarget(lifetime: reactive.lifetime, action: { isActive in
            isActive ? self.openMainFlow() : self.openAuthFlow()
            self.shouldChangeFlowAnimated = true
        })
    }
}
