//
//  AuthViewController.swift
//  GithubTrends
//
//  Created by Владислав  on 23.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

final class AuthViewController: BaseViewController {
    
    @IBOutlet private weak var authButton: GradientButton!
    
    var viewModel: AuthViewModel! {
        didSet {
            didSet(viewModel, for: reactive.lifetime)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
		
    }

    func didSet(_ viewModel: AuthViewModel, for lifetime: Lifetime) {
        // Collecting view input
        let authButtonPressed = authButton.reactive.controlEvents(UIControlEvents.touchUpInside).take(during: lifetime)
        
        let input = AuthViewModel.Input(
            authButtonPressed: authButtonPressed.mapToVoid()
    	)
        
        let output = viewModel.transform(input)
    }
}
