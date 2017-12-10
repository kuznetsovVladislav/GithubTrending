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

class ProfileCoordinator: BaseCoordinator, CoordinatorProtocol {
    
    var containerController: BaseContainerControllerProtocol
    var services: ServicesProvider
    var childs: [CoordinatorProtocol] = []
    var shouldRemoveFromParent: Signal<(), NoError>?
    
    init(services: ServicesProvider, containerController: BaseContainerControllerProtocol) {
        self.services = services
        self.containerController = containerController
    }
    
    func start() {
        
    }
    

}
