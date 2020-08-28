//
//  UpdateProfileCall.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-26.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import Foundation

struct UpdateProfileCall: Encodable {
    
    let firstName: String
    let lastName: String
    let userName: String
    
    init(profile: Profile) {
        
        firstName = profile.firstName
        lastName = profile.lastName
        userName = profile.userName
    }
}

extension UpdateProfileCall: APIParser {
    typealias DecodableType = APIResult<Profile>
}

extension UpdateProfileCall: APIRequest {

    var method: HTTPMethod {
        return .post
    }

    var url: URL {
        return formatPath(format: "profiles/update")
    }
    
    var parameters: [String: Any]? {
        return ["firstName": firstName, "lastName": lastName]
    }
}

extension APIClient {

    func updateProfile(profile: Profile, _ completion: @escaping (APIResponse<APIResult<Profile>>) -> Void) {

        let call = UpdateProfileCall(profile: profile)
        
        sessionManager.data(call) { response in
            self.handleResponse(call, response: response, completionHandler: completion)
        }
    }
}
