//
//  UITableView+Placer.swift
//  Placer
//
//  Created by Владислав  on 23.07.17.
//  Copyright © 2017 Placer. All rights reserved.
//

import UIKit

extension UITableView {
  func setTableHeaderViewHeight(_ height: CGFloat) {
    tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0,
                                           height: height == 0 ? CGFloat.leastNonzeroMagnitude : height))
  }
  
  func setTableFooterViewHeight(_ height: CGFloat) {
    tableFooterView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0,
                                           height: height == 0 ? CGFloat.leastNonzeroMagnitude : height))
  }
  
  func registerNib<T>(for cellClass: T.Type) where T: UITableViewCell {
    let identifier = String(describing: cellClass)
    register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
  }
  
  func registerNib<T>(for cellClass: T.Type) where T: UIView {
    let identifier = String(describing: cellClass)
    register(UINib(nibName: identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: identifier)
  }
  
  func dequeueReusableCell<T: UITableViewCell>(cellClass: T.Type, for indexPath: IndexPath) -> T {
    return dequeueReusableCell(withIdentifier: String(describing: cellClass), for: indexPath) as! T
  }
  
  func dequeueReusableHeaderFooterView<T: UIView>(cellClass: T.Type) -> T {
    return dequeueReusableHeaderFooterView(withIdentifier: String(describing: cellClass)) as! T
  }
}

