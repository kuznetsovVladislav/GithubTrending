//
//  UIScrollView+Insets.swift
//  Placer
//
//  Created by Владислав  on 15.10.17.
//  Copyright © 2017 Placer. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift
import ReactiveCocoa

extension UIScrollView {
    func adjustInsetsOnKeyboardNotification(extraBottomInset: CGFloat = 0.0) {
        NotificationCenter.default.reactive.keyboardChange
            .take(during: reactive.lifetime)
            .observe(on: UIScheduler())
            .observeValues { [weak self] context in
                guard let `self` = self else { return }
                UIView.animate(withDuration: context.animationDuration, animations: {
                    self.contentInset.bottom = UIScreen.main.bounds.height - context.endFrame.origin.y - extraBottomInset
                    self.scrollIndicatorInsets.bottom = self.contentInset.bottom
                })
        }
    }
    
    func adjustInsetsAndOffsetOnKeyboardNotification(extraBottomInset: CGFloat = 0.0, extraBottomOffset: CGFloat = 0.0) {
        NotificationCenter.default.reactive.keyboardChange
            .take(during: reactive.lifetime)
            .observe(on: UIScheduler())
            .observeValues { [weak self] context in
                guard let `self` = self else { return }
                
                let deltaY = context.endFrame.origin.y - context.beginFrame.origin.y
                
                var contentOffset = self.contentOffset
                contentOffset.y -= deltaY + extraBottomOffset
                var contentInset = self.contentInset
                contentInset.bottom -= deltaY + extraBottomInset
                
                UIView.animateKeyframes(withDuration: context.animationDuration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: UInt(context.animationCurve.rawValue)), animations: {
                    self.setContentOffset(contentOffset, animated: false)
                    self.contentInset = contentInset
                    self.layoutIfNeeded()
                },completion: nil)
        }
    }
}
