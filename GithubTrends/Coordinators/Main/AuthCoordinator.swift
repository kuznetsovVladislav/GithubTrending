//
//  AuthCoordinator.swift
//  GithubTrends
//
//  Created by Владислав  on 23.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

final class AuthCoordinator: BaseCoordinator, CoordinatorProtocol {
    
    var containerController: BaseContainerControllerProtocol
    var services: ServicesProvider
    var childs: [CoordinatorProtocol] = []
    var shouldRemoveFromParent: Signal<(), NoError>?
    
    private let shouldChangeFlowAnimated: Bool

    init(services: ServicesProvider, containerController: BaseContainerControllerProtocol, shouldChangeFlowAnimated: Bool) {
        self.services = services
        self.containerController = containerController
        self.shouldChangeFlowAnimated = shouldChangeFlowAnimated
    }
    
    func start() {
        let controller = containerController.changeFlow(to: .auth, animated: shouldChangeFlowAnimated)
        shouldRemoveFromParent = controller.reactive.lifetime.ended.take(during: reactive.lifetime).mapToVoid()
    }

}
