//
//  UpdatePasswordCall.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-26.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import Foundation

struct UpdatePasswordCall {
    
    let currentPassword: String
    let newPassword: String
    let passwordConfirmation: String
}

extension UpdatePasswordCall: APIParser {
    typealias DecodableType = APIResult<String>
}

extension UpdatePasswordCall: APIRequest {

    var method: HTTPMethod {
        return .post
    }

    var url: URL {
        return formatPath(format: "password/change")
    }
    
    var parameters: [String: Any]? {
        return ["currentPassword": currentPassword, "newPassword": newPassword, "passwordConfirmation": passwordConfirmation]
    }
}

extension APIClient {

    func updatePassword(currentPass: String, newPass: String, confirmPass: String, _ completion: @escaping (APIResponse<APIResult<String>>) -> Void) {
        let call = UpdatePasswordCall(currentPassword: currentPass, newPassword: newPass, passwordConfirmation: currentPass)

        sessionManager.data(call) { response in
            self.handleResponse(call, response: response, completionHandler: completion)
        }
    }
}
