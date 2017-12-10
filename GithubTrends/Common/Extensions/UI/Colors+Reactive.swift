//
//  Colors+Reactive.swift
//  GithubTrends
//
//  Created by Владислав  on 12/9/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa
import Result

extension Reactive where Base: UIColor {
    static var tableBackground: SignalProducer<UIColor, NoError> {
        return AppTheme.current.side.producer.map {
            $0 == .darkSide ? UIColor.TableBackground.dark : UIColor.TableBackground.bright
        }
    }
}

extension UIColor {
    struct TableBackground {
        static let bright = UIColor(white: 240.0/255.0, alpha: 1.0)
        static let dark = UIColor.black//(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
    }
}
