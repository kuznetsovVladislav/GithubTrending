//
//  ApiSessionManager.swift
//  GithubTrends
//
//  Created by Владислав  on 25.11.2017.
//  Copyright © 2017 Vlad Kuznetsov. All rights reserved.
//

import UIKit
import Alamofire

class ApiSessionManager: SessionManager {
    override func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> DataRequest {
        let minStatusCode = 200 // min valid status code
        let maxStatusCode = 1100 // perhaps max valid status code
        let notValidStatusCode = 401 // not valid status code for handling refresh token
        let validStatusCodes = (minStatusCode..<maxStatusCode).filter{$0 != notValidStatusCode}
        return super.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .validate(statusCode: validStatusCodes)
    }
    
    func requestWithoutValidate(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders? = nil) -> DataRequest {
        return super.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
}
