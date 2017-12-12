//
//  UIView+Constraints.swift
//  GithubTrends
//
//  Created by Владислав  on 12/11/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit

protocol UIEdgeInsetsConvertible {
    var converted: UIEdgeInsets { get }
}

struct UIEdgeZeroInsets: UIEdgeInsetsConvertible {
    var converted: UIEdgeInsets {
        return .zero
    }
}

struct UIEdgeLeftInsets: UIEdgeInsetsConvertible {
    let top: CGFloat
    let left: CGFloat
    let bottom: CGFloat
    
    var converted: UIEdgeInsets {
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: 0.0)
    }
}

struct UIEdgeRightInsets: UIEdgeInsetsConvertible {
    let top: CGFloat
    let right: CGFloat
    let bottom: CGFloat
    
    var converted: UIEdgeInsets {
        return UIEdgeInsets(top: top, left: 0.0, bottom: bottom, right: right)
    }
}

struct UIEdgeTopInsets: UIEdgeInsetsConvertible {
    let top: CGFloat
    let left: CGFloat
    let right: CGFloat
    
    var converted: UIEdgeInsets {
        return UIEdgeInsets(top: top, left: left, bottom: 0.0, right: right)
    }
}

struct UIEdgeBottomInsets: UIEdgeInsetsConvertible {
    let left: CGFloat
    let right: CGFloat
    let bottom: CGFloat
    
    var converted: UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: left, bottom: bottom, right: right)
    }
}



enum ViewConstrainSide {
    case top
    case bottom
}

struct ViewConstraint {
    let height: CFloat
    let side: ViewConstrainSide
}

extension UIView {
    /**
     Constrains view to its super view is the one is found
 	*/
    func constrainToSuperview(insets: UIEdgeInsetsConvertible = UIEdgeZeroInsets()) {
        guard let superview = superview else { fatalError("Unable to find superview") }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.converted.left),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: insets.converted.right),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.converted.top),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: insets.converted.bottom)]
        )
    }
    
    /**
     Constrains view to its super view is the one is found,
     but instead of constraining to top anchor - contrains it to topLayoutGuide
     */
    func constrainToSuperview(and topLayoutGuideAnchor: NSLayoutYAxisAnchor, insets: UIEdgeTopInsets = UIEdgeTopInsets(top: 0.0, left: 0.0, right: 0.0)) {
        guard let superview = superview else { fatalError("Unable to find superview") }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.converted.left),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: insets.converted.right),
            topAnchor.constraint(equalTo: topLayoutGuideAnchor, constant: insets.converted.top),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: insets.converted.bottom)]
        )
    }
    
    /**
     Constrains view top left and bottom anchors, topLayout guide
     and sets constrained height
     - Returns: heightLayoutConstraint for UI Changes
     */
    @discardableResult
    func constrainToSuperview(andTopAnchorOf layoutGuide: UILayoutGuide, constrainedHeight height: CGFloat) -> NSLayoutConstraint {
        guard let superview = superview else { fatalError("Unable to find superview") }
        translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = heightAnchor.constraint(equalToConstant: height)
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            heightConstraint]
        )
        return heightConstraint
    }
}
