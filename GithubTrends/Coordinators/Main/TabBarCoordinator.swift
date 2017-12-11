//
//  TabBarCoordinator.swift
//  GithubTrends
//
//  Created by Владислав  on 12/10/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

final class TabBarCoordinator: BaseCoordinator, CoordinatorProtocol {

    private var tabBarController: BaseTabBarController!
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
        self.tabBarController = tabBarController
        
        let trendingsCoordinator = TrendsCoordinator(services: services, containerController: containerController, tabBarController: tabBarController)
        trendingsCoordinator.start()
        add(child: trendingsCoordinator)
        
        let favouritedCoordinator = FavouritedCoordinator(services: services, containerController: containerController, tabBarController: tabBarController)
        favouritedCoordinator.start()
        add(child: favouritedCoordinator)
        
        let profileCoordinator = ProfileCoordinator(services: services, containerController: containerController, tabBarController: tabBarController)
        profileCoordinator.start()
        add(child: profileCoordinator)
        
        shouldRemoveFromParent = tabBarController.reactive.lifetime.ended.take(during: reactive.lifetime).mapToVoid()
    }
}
