	//
//  Fonts+Extensions.swift
//  GithubTrends
//
//  Created by Владислав  on 12/7/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit

enum FontWeight: String {
    case regular = ""
    case light = "-Light"
    case bold = "-Bold"
    case semibold = "-Semibold"
    case medium = "-Medium"
}

extension UIFont {
    static func font(withName name: String, ofSize size: CGFloat, weight: FontWeight) -> UIFont {
        let name = name + weight.rawValue
        if let font = UIFont(name: name, size: size) {
            return font
        }
        fatalError("Font '\(name)' not found")
    }
}

extension UIFont {
    static func helveticaNeue(withSize size: CGFloat, weight: FontWeight) -> UIFont {
        let name = "HelveticaNeue"
        return font(withName: name, ofSize: size, weight: weight)
    }
}
