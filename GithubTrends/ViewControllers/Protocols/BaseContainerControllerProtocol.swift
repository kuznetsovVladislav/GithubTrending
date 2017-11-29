//
//  BaseContainerControllerProtocol.swift
//  GithubTrends
//
//  Created by Vlad Kuznetsov on 23.11.17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit

enum ApplicationFlow {
    case auth
    case main
}

protocol BaseContainerControllerProtocol {
    func changeFlow(to flow: ApplicationFlow, animated: Bool) -> UIViewController
}
