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
                    guard let json = value as? [String: Any] else {
                        observer.send(error: .unknown)
                        return
                    }
                    if let apiError = ApiError(json: json) {
                        observer.send(error: .apiError(apiError))
                        return
                    }
                    if let object = Object.initialize(withJSON: json) {
                        observer.send(value: object)
                        observer.sendCompleted()
                    } else {
                    	observer.send(error: .mapping)
                    }
                case .failure(let error):
                    observer.send(error: .internal(error))
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
                        observer.send(error: .unknown)
                        return
                    }
                    _ = json
                case .failure(let error):
                    observer.send(error: .internal(error))
                }
            })
        }
    }
    
    func sliceResponse<Object: Codable>(pagination: Pagination) -> SignalProducer<Slice<Object>, BaseError> {
        return SignalProducer { observer, disposable in
            self.responseJSON { response in
                switch response.result {
                case .success(let value):
                    guard let json = value as? [String: Any] else {
                        observer.send(error: .unknown)
                        return
                    }
                    if let apiError = ApiError(json: json) {
                        observer.send(error: .apiError(apiError))
                        return
                    }
                    guard
                        let total = json["total_count"] as? Int,
                        let items = json["items"] as? [[String: Any]] else {
                            observer.send(error: .unknown)
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
                case .failure(let error):
                    observer.send(error: .internal(error))
                }
            }
        }
    }
}


