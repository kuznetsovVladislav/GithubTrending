//
//  ReactiveTableViewDataSource.swift
//  GithubTrends
//
//  Created by Владислав  on 12/12/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

protocol ReactiveTableViewDataSource {
    associatedtype Element    
    func tableView(_ tableView: UITableView, observedEvent: Signal<Element, NoError>.Event)
}
