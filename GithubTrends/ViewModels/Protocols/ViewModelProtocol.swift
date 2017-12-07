//
//  asd.swift
//  GithubTrends
//
//  Created by Vlad Kuznetsov on 23.11.17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation

protocol ViewModelProtocol: class {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
