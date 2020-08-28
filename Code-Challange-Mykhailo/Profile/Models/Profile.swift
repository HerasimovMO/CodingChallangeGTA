//
//  Profile.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-26.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import Foundation

struct Profile: Codable, Hashable, Equatable {
    
    var firstName: String
    var userName: String
    var lastName: String
    
    init() {
        self.firstName = .empty
        self.userName = .empty
        self.lastName = .empty
    }
    
    var isValid: Bool {
        return !([firstName, userName, lastName].contains(where: { $0 == .empty }))
    }
}
