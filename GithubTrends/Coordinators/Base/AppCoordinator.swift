//
//  Coordinator.swift
//  GithubTrends
//
//  Created by Vlad Kuznetsov on 23.11.17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit

class AppCoordinator: CoordinatorProtocol {
    var containerController: BaseContainerControllerProtocol
    var services: ServicesProvider
    var childs: [CoordinatorProtocol] = []
    
    init(services: ServicesProvider, containerController: BaseContainerControllerProtocol) {
        self.services = services
        self.containerController = containerController
    }
    
    func start() {
        
    }
}
