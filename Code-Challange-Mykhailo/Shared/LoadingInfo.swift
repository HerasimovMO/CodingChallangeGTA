//
//  LoadingState.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-26.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import Foundation

typealias LoadInfo = (state: LoadingState, type: LoadingType)

enum LoadingType {

    case fullReload
    case loadNew
}

enum LoadingState {

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

extension LoadingState: Equatable {

    static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.willLoad, .willLoad),
             (.isLoading, .isLoading),
             (.failLoading, .failLoading),
             (.didLoad, .didLoad):
            return true
        default:
            return false
        }
    }
}
