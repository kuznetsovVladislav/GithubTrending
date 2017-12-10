//
//  AppTheme.swift
//  GithubTrends
//
//  Created by Владислав  on 12/9/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result

final class AppTheme {

    enum Side: Int {
        case darkSide = 1
        case brightSide = 2
    }
    
    static let current = AppTheme()
    
    let side: MutableProperty<Side>
    
    private init() {
        if let sideRawValue = UserDefaults.standard.object(forKey: Key.side) as? Int, let side = Side(rawValue: sideRawValue) {
            self.side = MutableProperty(side)
        } else {
            side = MutableProperty(.brightSide)
        }
        side.producer.startWithValues { side in
            self.save(side)
        }
    }
    
    private func save(_ side: Side) {
        UserDefaults.standard.setValue(side.rawValue, forKey: Key.side)
        UserDefaults.standard.synchronize()
    }
}


// MARK: - Keys
fileprivate enum Key {
    static let side: String = "side"
}
