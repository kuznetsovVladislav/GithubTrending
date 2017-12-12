//
//  Reactive+Extensions.swift
//  GithubTrends
//
//  Created by Владислав  on 23.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa
import Result

extension SignalProducer {
    func mapToVoid() -> SignalProducer<(), Error> {
        return map { _ in () }
    }
}

extension Signal {
    func mapToVoid() -> Signal<(), Error> {
        return map { _ in () }
    }
}

extension MutablePropertyProtocol {
    func bind<Element, S: SignalProducerConvertible>(appending values: S)
        where S.Value == [Element], S.Value == Self.Value, S.Error == NoError
    {
        self <~ values.producer.withLatest(from: producer).map {$1 + $0}
    }
}
