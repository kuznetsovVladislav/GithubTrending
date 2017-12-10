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
    private var authViewController: AuthViewController?

    init(services: ServicesProvider, containerController: BaseContainerControllerProtocol, shouldChangeFlowAnimated: Bool) {
        self.services = services
        self.containerController = containerController
        self.shouldChangeFlowAnimated = shouldChangeFlowAnimated
    }
    
    func start() {
        guard let authViewController = containerController.changeFlow(to: .auth, animated: shouldChangeFlowAnimated) as? AuthViewController else {
            return
        }
        self.authViewController = authViewController
        let actions = AuthViewModel.Actions(authAction: Action(execute: openWebViewController))
        let viewModel = AuthViewModel(
            services: services,
            actions: actions
        )
        authViewController.viewModel = viewModel
        shouldRemoveFromParent = authViewController.reactive.lifetime.ended.take(during: reactive.lifetime).mapToVoid()
    }
    
    private func openWebViewController() -> SignalProducer<(), NoError> {
        return SignalProducer { observer, disposable in
			self.services.authService.signIn().start()
//            let storyboard = UIStoryboard(name: "Auth", bundle: nil)
//            let controller = storyboard.instantiateViewController(withIdentifier: "WebViewNavigationController")
//            self.authViewController?.present(controller, animated: true, completion: nil)
        }
    }

}
