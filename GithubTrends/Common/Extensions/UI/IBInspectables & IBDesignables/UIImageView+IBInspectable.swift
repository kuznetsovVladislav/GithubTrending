//
//  UIImageView+IBInspectable.swift
//  GithubTrends
//
//  Created by Владислав  on 12/8/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class DesignableImageView: UIImageView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            guard let borderColor = layer.borderColor else { return nil}
            return UIColor(cgColor: borderColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
}
