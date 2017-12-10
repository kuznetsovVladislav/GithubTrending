//
//  AppDelegate.swift
//  GithubTrends
//
//  Created by Vlad Kuznetsov on 23.11.17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import MagicalRecord
import OAuthSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupCoreData()
        
        setupAppCoordinator()
        
        return true
    }
    
    /**
     Setup Core Data stack
     */
    private func setupCoreData() {
        MagicalRecord.setShouldDeleteStoreOnModelMismatch(true)
        MagicalRecord.setupCoreDataStack(withAutoMigratingSqliteStoreNamed: "DataModel")
        MagicalRecord.setShouldAutoCreateDefaultPersistentStoreCoordinator(true)
        MagicalRecord.setShouldAutoCreateManagedObjectModel(true)
    }
    
    /**
     Setup Main Application Flow
     */
    private func setupAppCoordinator() {
		window = UIWindow(frame: UIScreen.main.bounds)
        let baseContainerController = BaseContainerController()
        window?.rootViewController = baseContainerController
        window?.makeKeyAndVisible()
        
        let apiService = ApiService(configuration: .development)
        let services = ServicesProvider(apiService: apiService)
        appCoordinator = AppCoordinator(services: services, containerController: baseContainerController)
        appCoordinator.start()
    }
}

extension AppDelegate {
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.host == "https://github.com/app-github-trends" {
            OAuthSwift.handle(url: url)
        }
        return true
    }
}
