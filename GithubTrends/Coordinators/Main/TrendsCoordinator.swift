//
//  TrendsCoordinator.swift
//  GithubTrends
//
//  Created by Владислав  on 23.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

final class TrendsCoordinator: BaseCoordinator, CoordinatorProtocol {
    
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
        guard let tabBarController = containerController.changeFlow(to: .main, animated: shouldChangeFlowAnimated) as? BaseTabBarController else {
            return
        }
        let viewModel = TrendingViewModel(services: services)
        tabBarController.trendingsController.viewModel = viewModel
        shouldRemoveFromParent = tabBarController.reactive.lifetime.ended.take(during: reactive.lifetime).mapToVoid()
    }
    
}
