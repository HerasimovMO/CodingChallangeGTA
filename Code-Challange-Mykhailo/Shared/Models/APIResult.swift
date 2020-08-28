//
//  APIResult.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-26.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import Foundation

class APIResult<T: Decodable>: Decodable {
    
    var message: String
    var data: T?
    var code: String?
    var exceptionName: String?

    enum CodingKeys: String, CodingKey {
        case message, data, code, exceptionName
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        message = try values.decode(String.self, forKey: .message)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        exceptionName = try values.decodeIfPresent(String.self, forKey: .exceptionName)
        data = try values.decodeIfPresent(T.self, forKey: .data)
    }
}
