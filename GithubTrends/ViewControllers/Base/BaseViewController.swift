//
//  BaseViewController.swift
//  GithubTrends
//
//  Created by Vlad Kuznetsov on 23.11.17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, BaseViewControllerProtocol {

    // MARK: - Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        printFunction(#function)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        printFunction(#function)
    }
    
    // MARK: - Private methods
    
    private func printFunction(_ function: String) {
        print("\(self) \(function)")
    }
}
