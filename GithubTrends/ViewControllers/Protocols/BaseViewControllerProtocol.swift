//
//  BaseViewControllerProtocol.swift
//  GithubTrends
//
//  Created by Vlad Kuznetsov on 23.11.17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift

protocol BaseViewControllerProtocol {}

extension BaseViewControllerProtocol where Self: UIViewController {
    func showIndicator() {
        
    }
    
    func hideIndicator() {
    
    }
}


