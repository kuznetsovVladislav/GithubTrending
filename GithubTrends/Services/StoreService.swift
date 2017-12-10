//
//  StoreService.swift
//  GithubTrends
//
//  Created by Владислав  on 30.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import MagicalRecord
import CoreData
import ReactiveSwift
import Result

protocol StoreServiceProvider {
    var storeService: StoreServiceProtocol { get }
}

protocol StoreServiceProtocol {
    func fetch<Object: DomainConvertible>(objectsOfType type: Object.Type) -> SignalProducer<[Object], NoError>
    func save<Object: DomainConvertible>(_ domain: Object.Domain, toStoreAs managedObject: Object.Type) -> SignalProducer<Object, BaseError>
}

final class StoreService: StoreServiceProtocol {
    
    func fetch<Object: DomainConvertible>(objectsOfType type: Object.Type) -> SignalProducer<[Object], NoError> {
        return SignalProducer { observer, disposable in
            guard
                let type = type as? NSManagedObject.Type,
                let objects = type.findAll() as? [Object] else {
                	fatalError("Wrong Types usage")
            }
            observer.send(value: objects)
            observer.sendCompleted()
        }
    }
    
    // Currently not working
    func save<Object: DomainConvertible>(_ domain: Object.Domain, toStoreAs managedObject: Object.Type) -> SignalProducer<Object, BaseError> {
        return SignalProducer { observer, dispoable in
            var object: Object!
            NSManagedObjectContext.default.mr_save({ _ in
                object = Object(domain: domain)
            }, completion: { success, error in
                if let error = error {
                    observer.send(error: .storeError(error))
                } else if !success {
                    observer.send(error: .unknown) // Context does not have any changes
                } else {
                    observer.send(value: object)
                    observer.sendCompleted()
                }
            })
        }
    }
    
}
