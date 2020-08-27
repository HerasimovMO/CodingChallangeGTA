//
//  APIParser.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-26.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import Foundation

protocol APIParser {
    
    associatedtype DecodableType: Decodable
    func parseResponse(_ data: Data) -> APIResponse<DecodableType>
}

extension APIParser {
    func parseResponse(_ data: Data) -> APIResponse<DecodableType> {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedData = try decoder.decode(DecodableType.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(.decodingError(error))
        }
    }
}
