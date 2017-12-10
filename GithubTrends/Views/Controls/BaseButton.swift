//
//  BaseButton.swift
//  GithubTrends
//
//  Created by Владислав  on 12/9/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit

@IBDesignable
class BaseButton: UIButton {
    
    private var _highlightedColor: UIColor? = nil
    private lazy var _backgroundColor: UIColor? = backgroundColor

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
            guard let borderColor = layer.borderColor else { return nil }
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
    
    @IBInspectable
    var highlightedColor: UIColor? {
        get {
            return _highlightedColor
        }
        set {
            _highlightedColor = newValue
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            guard let _hightlightedColor = _highlightedColor else {
                backgroundColor = _backgroundColor
                return
            }
            backgroundColor = isHighlighted ? _hightlightedColor : _backgroundColor
        }
    }

}
