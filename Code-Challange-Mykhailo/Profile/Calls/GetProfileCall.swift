//
//  GetProfileCall.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-26.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import Foundation

struct GetProfileCall {}

extension GetProfileCall: APIParser {
    typealias DecodableType = APIResult<Profile>
}

extension GetProfileCall: APIRequest {

    var method: HTTPMethod {
        return .get
    }

    var url: URL {
        return formatPath(format: "profiles/mine")
    }
    
    var parameters: [String: Any]? {
        return nil
    }
}

extension APIClient {

    func getProfile(_ completion: @escaping (APIResponse<APIResult<Profile>>) -> Void) {
        let call = GetProfileCall()

        sessionManager.data(call) { response in
            self.handleResponse(call, response: response, completionHandler: completion)
        }
    }
}
