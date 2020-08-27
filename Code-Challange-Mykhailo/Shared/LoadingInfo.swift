//
//  LoadingState.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-26.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import Foundation

enum LoadingState: Equatable {

    case willLoad
    case isLoading
    case failLoading
    case didLoad

    var isActive: Bool {

        switch self {
        case .isLoading, .willLoad:
            return true
        case .failLoading, .didLoad:
            return false
        }
    }
}
