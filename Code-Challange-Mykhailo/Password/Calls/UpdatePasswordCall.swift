//
//  UpdatePasswordCall.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-26.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import Foundation

struct UpdatePasswordCall {
    
    var currentPassword: String
    var newPassword: String
    var passwordConfirmation: String
    
    init(currentPassword: String = .empty, newPassword: String = .empty, passwordConfirmation: String = .empty) {
        self.currentPassword = currentPassword
        self.newPassword = newPassword
        self.passwordConfirmation = passwordConfirmation
    }
    
    var isValid: Bool {
        return !([currentPassword, newPassword, passwordConfirmation].contains(where: { $0 == .empty }))
    }
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

    func updatePassword(call: UpdatePasswordCall, _ completion: @escaping (APIResponse<APIResult<String>>) -> Void) {
        
        sessionManager.data(call) { response in
            self.handleResponse(call, response: response, completionHandler: completion)
        }
    }
}
