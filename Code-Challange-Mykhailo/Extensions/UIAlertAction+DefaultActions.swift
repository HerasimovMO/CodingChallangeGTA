//
//  UIAlertAction+DefaultActions.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-27.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import UIKit

extension UIAlertAction {

    static let ok = UIAlertAction(title: NSLocalizedString("OK", comment: "OK button on alert."), style: .default)
    static let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel button on alert."), style: .cancel)

    convenience init(title: String, style: Style = .default, handler: (() -> Void)? = nil) {
        self.init(title: NSLocalizedString(title, comment: "Alert button title"), style: style) { _ in
            handler?()
        }
    }
}
