//
//  UIView+Constraints.swift
//  GithubTrends
//
//  Created by Владислав  on 12/11/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit


extension UIView {
    /**
     Constrains view to its super view is the one is found
 	*/
    func constrainToSuperview(insets: UIEdgeInsets = .zero) {
        guard let superview = superview else { fatalError("Unable to find superview") }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: insets.right),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: insets.bottom)]
        )
    }
}
