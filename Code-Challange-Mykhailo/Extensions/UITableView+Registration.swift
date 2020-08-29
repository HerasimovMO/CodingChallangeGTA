//
//  UITableView+Registration.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-28.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import UIKit

extension UITableView {

    public func register<T: UITableViewCell>(_: T.Type) {

        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    public func register<T: UITableViewHeaderFooterView>(_: T.Type) {

        register(T.self, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
    }

    public func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }

        return cell
    }

    public func dequeueReusableCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }

        return cell
    }

    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let headerOrFooter = dequeueReusableHeaderFooterView(withIdentifier: T.defaultReuseIdentifier) as? T else {
            fatalError("Could not dequeue header or footer with identifier: \(T.defaultReuseIdentifier)")
        }

        return headerOrFooter
    }
}

