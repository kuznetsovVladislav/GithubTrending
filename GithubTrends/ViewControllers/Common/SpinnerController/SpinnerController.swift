//
//  SpinnerController.swift
//  GithubTrends
//
//  Created by Владислав  on 12/7/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit

class SpinnerController: UIViewController {
    
    @IBOutlet private weak var blurView: UIVisualEffectView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
		setup()
    }
    
    deinit {
        print("\(self) \(#function)")
    }

    private func setup() {
        blurView.layer.cornerRadius = 12.0
    }
}
