//
//  Collection+Extension.swift
//  GithubTrends
//
//  Created by Владислав  on 30.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Array where Element: Equatable {
    
    /// Remove first collection element that is equal to the given `object`:
    @discardableResult
    mutating func remove(_ object: Element) -> Element? {
        if let index = index(of: object) {
            return remove(at: index)
        }
        return nil
    }
    
    /// Removes array of elements
    mutating func remove(contentsOf elements: [Element]) {
        elements.forEach {remove($0)}
    }
    
    mutating func replace(_ object: Element, with newElement: Element) {
        if let index = index(of: object) {
            self[index] = newElement
        }
    }
    
    mutating func appendOrReplace(_ object: Element) {
        if let index = index(of: object) {
            self[index] = object
        } else {
            append(object)
        }
    }
    
    mutating func appendOrReplace(contentsOf elements: [Element]) {
        elements.forEach {appendOrReplace($0)}
    }
}

extension Array {
    mutating func moveItem(from oldIndex: Index, to newIndex: Index) {
        let removedObject = remove(at: oldIndex)
        insert(removedObject, at: newIndex)
    }
}
