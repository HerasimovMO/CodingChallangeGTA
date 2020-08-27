//
//  Profile.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-26.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import Foundation

struct Profile: Codable, Hashable, Equatable {
    
    let firstName: String
    let userName: String
    let lastName: String
}
