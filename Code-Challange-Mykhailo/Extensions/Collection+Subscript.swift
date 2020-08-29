//
//  Collection+Subscript.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-29.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import Foundation

extension Array {

    /// Returns or sets the element at the specified index if it is within bounds, otherwise returns nil or does nothing
    public subscript(safe index: Int) -> Element? {
        get {
            return index < count ? self[index] : nil
        }
        set {
            guard let newValue = newValue else { return }
            guard indices.contains(index) else {

                isEmpty ? append(newValue) : Void()
                return
            }

            self[index] = newValue
        }
    }
}
