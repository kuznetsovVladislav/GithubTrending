//
//  FavouritedCoordinator.swift
//  GithubTrends
//
//  Created by Владислав  on 12/10/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

final class FavouritedCoordinator: BaseCoordinator, CoordinatorProtocol {
    
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
            let favouritedNavigationController = UIStoryboard(name: "Favourited", bundle: nil).instantiateInitialViewController() as? UINavigationController,
            let favouritedViewController = favouritedNavigationController.viewControllers.first as? FavouritedViewController else {
                return
        }
        if tabBarController.viewControllers != nil {
            tabBarController.viewControllers?.append(favouritedNavigationController)
        } else {
            tabBarController.viewControllers = [favouritedNavigationController]
        }
        shouldRemoveFromParent = favouritedNavigationController.reactive.lifetime.ended.take(during: reactive.lifetime).mapToVoid()
    }
}
