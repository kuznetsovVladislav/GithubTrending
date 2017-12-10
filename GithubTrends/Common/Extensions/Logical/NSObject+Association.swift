//
//  Assosication.swift
//  GithubTrends
//
//  Created by Владислав  on 12/7/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation

extension NSObject {
    enum AssociationPolicy {
        case assign
        case copy
        case retain
        case copyNonatomic
        case retainNonatomic
        
        var objcValue: objc_AssociationPolicy {
            switch self {
            case .assign:
                return .OBJC_ASSOCIATION_ASSIGN
            case .copy:
                return .OBJC_ASSOCIATION_COPY
            case .retain:
                return .OBJC_ASSOCIATION_RETAIN
            case .copyNonatomic:
                return .OBJC_ASSOCIATION_COPY_NONATOMIC
            case .retainNonatomic:
                return .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            }
        }
    }
    
    func setAssociated<T>(object: T, for key: UnsafeRawPointer, policy: AssociationPolicy = .retain) {
        objc_setAssociatedObject(self, key, object, policy.objcValue)
    }
    
    func getAssociatedObject<T>(for key: UnsafeRawPointer) -> T? {
        return objc_getAssociatedObject(self, key) as? T
    }
    
    func removeAssociatedObject(for key: UnsafeRawPointer) {
        objc_setAssociatedObject(self, key, nil, .OBJC_ASSOCIATION_RETAIN)
    }
}



