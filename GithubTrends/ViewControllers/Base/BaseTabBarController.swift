//
//  BaseTabBarController.swift
//  GithubTrends
//
//  Created by Владислав  on 12/7/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    enum Tab {
        case search
        case favourited
        case profile
    }
    
    var trendingsController: TrendsViewController {
        if
            let navigationController = viewControllers?.first as? UINavigationController,
            let controller = navigationController.viewControllers.first as? TrendsViewController
        {
            return controller
        }
        fatalError("Wrong controller was set")
    }
    
    var favouritedController: UIViewController {
        if
            let navigationController = viewControllers?[safe: 1] as? UINavigationController,
            let controller = navigationController.viewControllers.first as? FavouritedViewController
        {
            return controller
        }
        fatalError("Wrong controller was set")
    }
    
    var profileController: ProfileViewController {
        if
            let navigationController = viewControllers?[safe: 2] as? UINavigationController,
            let controller = navigationController.viewControllers.first as? ProfileViewController
        {
            return controller
        }
        fatalError("Wrong controller was set")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    deinit {
        print("\(self) \(#function)")
    }
}
