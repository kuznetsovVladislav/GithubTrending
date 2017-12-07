//
//  BaseContainerController.swift
//  GithubTrends
//
//  Created by Vlad Kuznetsov on 23.11.17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit

class BaseContainerController: UIViewController, BaseContainerControllerProtocol {
    
    enum Flow {
        case auth
        case main
    }

    private var authViewController: UIViewController?
    private var mainViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func changeFlow(to flow: ApplicationFlow, animated: Bool) -> UIViewController {
        switch flow {
        case .auth:
            return changeFlowToAuth(animated: animated)
        case .main:
            return changeFlowToMain(animated: animated)
        }
    }
    
    private func changeFlowToAuth(animated: Bool) -> UIViewController {
        dismissMainControllerIfNeeded()
        authViewController = instantiateAuthController()
        guard let authViewController = authViewController else { fatalError() }
        addChildViewController(authViewController)
        view.addSubview(authViewController.view)
        authViewController.view.frame = view.bounds
        authViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        authViewController.didMove(toParentViewController: self)
        return authViewController
    }
    
    private func changeFlowToMain(animated: Bool) -> UIViewController {
        dismissAuthControllerIfNeeded()
        mainViewController = instantiateMainController()
        guard let mainViewController = mainViewController else { fatalError() }
        addChildViewController(mainViewController)
        view.addSubview(mainViewController.view)
        mainViewController.view.frame = view.bounds
        mainViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainViewController.didMove(toParentViewController: self)
        return mainViewController
    }
    
    private func dismissAuthControllerIfNeeded() {
        guard let authViewController = authViewController else { return }
        authViewController.willMove(toParentViewController: nil)
        authViewController.view.removeFromSuperview()
        authViewController.removeFromParentViewController()
        self.authViewController = nil
    }
    
    private func dismissMainControllerIfNeeded() {
        guard let mainViewController = mainViewController else { return }
        mainViewController.willMove(toParentViewController: nil)
        mainViewController.view.removeFromSuperview()
        mainViewController.removeFromParentViewController()
        self.mainViewController = nil
    }
    
    private func instantiateAuthController() -> UIViewController {
        let authStoryboard = UIStoryboard(name: "Auth", bundle: nil)
        guard let authViewController = authStoryboard.instantiateInitialViewController() else {
        	fatalError("Unable to init `authViewController`")
        }
        return authViewController
    }
    
    private func instantiateMainController() -> UIViewController {
        let tabBarStoryboard = UIStoryboard(name: "TabBar", bundle: nil)
        guard let mainViewController = tabBarStoryboard.instantiateInitialViewController() else {
            fatalError("Unable to init `mainViewController`")
        }
        return mainViewController
    }
}
