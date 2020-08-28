//
//  UIView+CommonViewCreation.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-27.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import UIKit

extension UIView {

    class func createSeparator() -> UIView {

        let view = createEmpty()
        view.backgroundColor = .lightGray
        return view
    }

    class func createEmpty(borderWidth: CGFloat = 0, cornerRadius: CGFloat = 0, borderColor: UIColor = .clear, backgroundColor: UIColor = .white, contentPriority axies: [NSLayoutConstraint.PriorityAxis] = []) -> UIView {

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = borderColor.cgColor
        view.layer.borderWidth = borderWidth
        view.layer.cornerRadius = cornerRadius
        view.backgroundColor = backgroundColor
        view.configureRequiredPriorities(for: axies)
        return view
    }

    func configureRequiredPriorities(for axies: [NSLayoutConstraint.PriorityAxis]) {

        axies.forEach {

            switch $0 {
            case let .horizontal(priority), let .vertical(priority):

                setContentHuggingPriority(priority, for: $0.constraintAxis)
                setContentCompressionResistancePriority(priority, for: $0.constraintAxis)
            }
        }
    }
}

extension UITextField {

    class func create(placeholder: String, isSecureEntry: Bool = false, contentPriority axies: [NSLayoutConstraint.PriorityAxis] = [.vertical]) -> UITextField {

        let textField = UITextField()
        textField.isSecureTextEntry = isSecureEntry
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = placeholder
        textField.configureRequiredPriorities(for: axies)
        return textField
    }
}

extension UIStackView {

    class func create(axis: NSLayoutConstraint.Axis, spacing: CGFloat = 8, distribution: Distribution = .fill, alignment: Alignment = .fill) -> UIStackView {

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = spacing
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        return stackView
    }

    var items: [UIView] {
        set {
            newValue.forEach { addArrangedSubview($0) }
        }
        get {
            return arrangedSubviews
        }
    }
}

extension UILabel {

    class func create(font: UIFont, text: String? = nil, textColor: UIColor = UIColor.label, textAlignment: NSTextAlignment = .left, isDynamicallySized: Bool = false, contentPriority axies: [NSLayoutConstraint.PriorityAxis] = [.vertical]) -> UILabel {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = font
        label.text = text
        label.numberOfLines = isDynamicallySized ? 0 : 1
        label.textAlignment = textAlignment
        label.textColor = textColor
        label.configureRequiredPriorities(for: axies)
        return label
    }
}

extension UIButton {

    class func create(font: UIFont, text: String? = nil, textColor: UIColor = UIColor.label, textAlignment: ContentHorizontalAlignment = .center, backgroundColor: UIColor? = nil, borderWidth: CGFloat = 0, borderColor: UIColor = .black, cornerRadius: CGFloat = 0, contentPriority axies: [NSLayoutConstraint.PriorityAxis] = []) -> UIButton {

        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = font
        button.setTitle(text, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.contentHorizontalAlignment = textAlignment
        button.layer.borderColor = borderColor.cgColor
        button.layer.borderWidth = borderWidth
        button.layer.cornerRadius = cornerRadius
        
        if let backgroundColor = backgroundColor {
            
            button.clipsToBounds = true
            UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
            if let context = UIGraphicsGetCurrentContext() {
                context.setFillColor(backgroundColor.cgColor)
                context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
                let colorImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                button.setBackgroundImage(colorImage, for: .normal)
            }
            
            UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
            if let context = UIGraphicsGetCurrentContext() {
                context.setFillColor(UIColor.lightGray.cgColor)
                context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
                let colorImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                button.setBackgroundImage(colorImage, for: .disabled)
            }
        }
        
        button.configureRequiredPriorities(for: axies)
        return button
    }
}

extension UIRefreshControl {

    class func create(_ target: Any?, action: Selector) -> UIRefreshControl {

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(target, action: action, for: .valueChanged)
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }
}

extension UIActivityIndicatorView {

    class func create(style: Style, hidesWhenStopped: Bool = true) -> UIActivityIndicatorView {

        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.hidesWhenStopped = hidesWhenStopped
        return activityIndicator
    }
}

