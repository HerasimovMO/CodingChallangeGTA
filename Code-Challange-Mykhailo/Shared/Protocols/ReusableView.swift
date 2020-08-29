//
//  ReusableView.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-28.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import UIKit

public protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    public static var defaultReuseIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension UITableViewCell: ReusableView {}
extension UITableViewHeaderFooterView: ReusableView {}
