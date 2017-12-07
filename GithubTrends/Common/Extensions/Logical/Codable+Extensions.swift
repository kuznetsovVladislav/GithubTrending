//
//  CodingMappable.swift
//  GithubTrends
//
//  Created by Владислав  on 29.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import Foundation

extension Encodable {
    var json: [String: Any]? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(.utc)
        guard let data = try? encoder.encode(self) else { return nil }
        let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        let json = jsonObject.flatMap {$0 as? [String: Any]}
        return json
    }
}

extension Decodable {
    static func initialize(withJSON json: [String: Any]) -> Self? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.utc)
        guard
            let jsonData = try? JSONSerialization.data(withJSONObject: json),
            let decoded = try? decoder.decode(self, from: jsonData) else {
                return nil
        }
        return decoded
    }
}
