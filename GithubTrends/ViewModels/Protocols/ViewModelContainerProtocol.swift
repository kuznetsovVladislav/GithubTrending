//
//  ViewModelContainerProtocol.swift
//  GithubTrends
//
//  Created by Vlad Kuznetsov on 23.11.17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol ViewModelContainerProtocol: class {
    associatedtype ViewModel
    
    var viewModel: ViewModel! { get set }
    func didSet(_ viewModel: ViewModel, for lifetime: Lifetime)
}
