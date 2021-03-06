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
            let trendingsNavigationController = UIStoryboard(name: "Search", bundle: nil).instantiateInitialViewController() as? UINavigationController,
        	let trendingViewController = trendingsNavigationController.viewControllers.first as? TrendsViewController else {
                return
        }
        let viewModel = TrendingViewModel(services: services)
        trendingViewController.viewModel = viewModel
        if tabBarController.viewControllers != nil {
            tabBarController.viewControllers?.append(trendingsNavigationController)
        } else {
            tabBarController.viewControllers = [trendingsNavigationController]
        }
        shouldRemoveFromParent = trendingsNavigationController.reactive.lifetime.ended.take(during: reactive.lifetime).mapToVoid()
    }
    
}
