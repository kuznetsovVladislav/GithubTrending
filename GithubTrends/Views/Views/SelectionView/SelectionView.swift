//
//  SelectionViewController.swift
//  GithubTrends
//
//  Created by Владислав  on 12/7/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit

protocol SelectionControllerItemProtocol {
    var content: String { get }
}

final class SelectionView: UIView {
    
    @IBOutlet private weak var pickerView: UIPickerView!
    @IBOutlet private weak var doneButton: UIButton!
    
    private var items: [SelectionControllerItemProtocol] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with items: [SelectionControllerItemProtocol]) {
        self.items = items
    }
}

// MARK: - UIPickerViewDataSource
extension SelectionView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

// MARK: - UIPickerViewDelegate
extension SelectionView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = items[row]
        return item.content
    }
}

