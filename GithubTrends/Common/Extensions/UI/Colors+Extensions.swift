//
//  Colors+Extensions.swift
//  GithubTrends
//
//  Created by Владислав  on 12/9/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit

extension UIColor {
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat) {
        return (coreImageColor.red, coreImageColor.green, coreImageColor.blue)
    }
    
    func darkened(by value: CGFloat) -> UIColor {
        let convertedValue = value / 255.0
        return UIColor(
            red: components.red - convertedValue,
            green: components.green - convertedValue,
            blue: components.blue - convertedValue,
            alpha: 1.0
        )
    }
}

