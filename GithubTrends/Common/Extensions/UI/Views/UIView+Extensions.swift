//
//  UIView+Extensions.swift
//  GithubTrends
//
//  Created by Владислав  on 12/7/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit

protocol NibLoadable: class {}
protocol StoryboardLoadable {}
extension UIView: NibLoadable {}
extension UIViewController: NibLoadable {}
extension UIStoryboard: StoryboardLoadable {}

extension NibLoadable where Self: UIView {
    static func instantiateFromNib() -> Self {
        let nibName = "\(Self.self)"
        return UINib(nibName: nibName, bundle: nil)
            .instantiate(withOwner: nil, options: nil).first as! Self
    }
}

extension NibLoadable where Self: UIViewController {
    static func instantiateFromNib() -> Self {
        let nibName = "\(Self.self)"
        return Self(nibName: nibName, bundle: nil)
    }
}

extension StoryboardLoadable where Self: UIStoryboard {
    func instantiateController<T>(ofType type: T.Type) -> T where T: UIViewController {
        let storyboardIdentifier = "\(T.self)"
        return instantiateViewController(withIdentifier: storyboardIdentifier) as! T
    }
}
