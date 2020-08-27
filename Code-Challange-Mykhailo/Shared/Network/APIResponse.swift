//
//  APIResponse.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-26.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import Foundation

public enum APIResponse<Value> {
    
    case success(Value)
    case failure(APIError)

    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }

    public var value: Value? {
        switch self {
        case let .success(value):
            return value
        case .failure:
            return nil
        }
    }

    public var error: APIError? {
        switch self {
        case .success:
            return nil
        case let .failure(error):
            return error
        }
    }
}
