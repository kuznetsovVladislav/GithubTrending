//
//  Assosication.swift
//  GithubTrends
//
//  Created by Владислав  on 12/7/17.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation

enum AssociationPolicy {
	case assign
    case copy
    case retain
    case copyNonatomic
    case retainNonatomic
    
    var objValue: objc_AssociationPolicy {
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

func setAssociated<T>(value: T?, sourceObject object: Any, for key: String, policy: AssociationPolicy) {
    objc_setAssociatedObject(object, key, value, policy.objValue)
}

func getAssociatedObject<T>(for key: String, sourceObject object: Any) -> T? {
    return objc_getAssociatedObject(object, key) as? T
}

func removeAssociatedObject(for key: String, sourceObject object: Any) {
    objc_setAssociatedObject(object, key, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
}
