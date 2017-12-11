//
//  BaseViewController.swift
//  GithubTrends
//
//  Created by Vlad Kuznetsov on 23.11.17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    
    // MARK: - Variables
    
    private lazy var errorView: ErrorView = setupErrorView()
    private var errorViewHeight: NSLayoutConstraint?

    // MARK: - Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        printRunning(#function)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        printRunning(#function)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        printRunning(#function)
    }
    
    // MARK: - Private methods
    
    private func printRunning(_ function: String) {
        print("\(self) \(function)")
    }
    
    private func setupErrorView() -> ErrorView {
        let view = ErrorView.instantiateFromNib()
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)]
        )
        errorViewHeight = view.heightAnchor.constraint(equalToConstant: 0.0)
        errorViewHeight?.isActive = true
        self.view.layoutIfNeeded()
        return view
    }
    
    func showErrorView() {
        errorViewHeight?.constant = 50.0
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.errorView.showMessage(animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                self.hideErrorView()
            })
        })
    }
    
    func hideErrorView() {
        errorView.hideMessage(animated: true) { [unowned self] _ in
            self.errorViewHeight?.constant = 0.0
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
//    
//    var showError: BindingTarget<BaseError> {
//        return reactive.makeBindingTarget({ `self`, _ in
//            <#code#>
//        })
//    }
}
