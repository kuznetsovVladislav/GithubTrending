//
//  UICollectionView+Placer.swift
//  Placer
//
//  Created by Владислав  on 23.07.17.
//  Copyright © 2017 Placer. All rights reserved.
//

import UIKit

extension UICollectionView {
  
  func registerNib<T: UICollectionViewCell>(for cellClass: T.Type) {
    let identifier = String(describing: cellClass)
    register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
  }
  
  func dequeueReusableCell<T: UICollectionViewCell>(cellClass: T.Type, for indexPath: IndexPath) -> T {
    return dequeueReusableCell(withReuseIdentifier: String(describing: cellClass), for: indexPath) as! T
  }
  
}
