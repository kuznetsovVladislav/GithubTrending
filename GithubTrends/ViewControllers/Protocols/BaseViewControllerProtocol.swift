//
//  BaseViewControllerProtocol.swift
//  GithubTrends
//
//  Created by Vlad Kuznetsov on 23.11.17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

protocol BaseViewControllerProtocol {}

extension BaseViewControllerProtocol where Self: UIViewController {
    func showIndicator() {
     	let spinnerController = SpinnerController.instantiateFromNib()
        present(spinnerController, animated: true, completion: nil)
    }
    
    func hideIndicator() {
    
    }
//    private var spinnerController: SpinnerController? {
//        get {
//            return getAssociatedObject(for: AssocationKey.spinnerController, sourceObject: self)
//        }
//        set {
//            if let spinnerController: SpinnerController? = getAssociatedObject(for: AssocationKey.spinnerController, sourceObject: self)  {
//                spinnerController?.dismiss(animated: true, completion: nil)
//            }
//            setAssociated(value: newValue, sourceObject: self, for: AssocationKey.spinnerController, policy: .retain)
//        }
//    }
}

fileprivate enum AssocationKey {
    static let spinnerController: String = "SpinnerController"
}

extension Reactive where Base: UIViewController & BaseViewControllerProtocol {
    func shouldShowSpinner() -> BindingTarget<Bool> {
        return makeBindingTarget { `self`, shouldShow in
            shouldShow ? self.showIndicator() : self.hideIndicator()
        }
    }
}
