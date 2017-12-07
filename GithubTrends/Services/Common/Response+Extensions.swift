//
//  Alamofire.Request+ReactiveResponse.swift
//  GithubTrends
//
//  Created by Владислав  on 27.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import ReactiveSwift
import ReactiveCocoa
import Result

extension DataRequest {    
    func singleResponse<Object: Codable>() -> SignalProducer<Object, BaseError> {
        return SignalProducer { observer, disposable in
            self.responseJSON { response in
                switch response.result {
                case .success(let value):
                    guard
                        let json = value as? [String: Any],
                        let object = Object.initialize(withJSON: json) else {
                            observer.send(error: .mapping)
                            return
                    }
                    observer.send(value: object)
                    observer.sendCompleted()
                case .failure(_): //TODO: Fix
                    break
                }
            }
        }
    }
    
    func arrayResponse<Object: Codable>() -> SignalProducer<[Object], BaseError> {
        return SignalProducer { observer, disposable in
            self.responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    guard let json = value as? [String: Any] else {
                        return //TODO: Fix
                    }
                    _ = json
                case .failure(_): //TODO: Fix
                    break
                }
            })
        }
    }
    
    func sliceResponse<Object: Codable>(pagination: Pagination) -> SignalProducer<Slice<Object>, BaseError> {
        return SignalProducer { observer, disposable in
            self.responseJSON { response in
                switch response.result {
                case .success(let value):
                    guard
                        let json = value as? [String: Any],
                        let total = json["total_count"] as? Int,
                        let items = json["items"] as? [[String: Any]] else {
                            observer.send(error: .mapping)
                            return
                    }
                    var objects: [Object] = []
                    items.forEach {
                        if let object = Object.initialize(withJSON: $0) {
                        	objects.append(object)
                        }
                    }
                    let slice: Slice<Object> = Slice(items: objects, total: total, pagination: pagination)
                    observer.send(value: slice)
                    observer.sendCompleted()
                case .failure(_):
                    break // TODO: Fix
                }
            }
        }
    }
}


