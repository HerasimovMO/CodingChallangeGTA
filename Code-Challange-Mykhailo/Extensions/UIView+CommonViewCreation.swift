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

    class func create(placeholder: String, contentPriority axies: [NSLayoutConstraint.PriorityAxis] = [.vertical]) -> UITextField {

        let textField = UITextField()
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
        }
        
        button.configureRequiredPriorities(for: axies)
        return button
    }
}

extension UISegmentedControl {

    class func create(font: UIFont, items: [String] = [], selectedSegment: Int? = nil, tintColor: UIColor) -> UISegmentedControl {

        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.tintColor = tintColor
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)

        if let selectedSegment = selectedSegment, items.indices.contains(selectedSegment) {
            segmentedControl.selectedSegmentIndex = selectedSegment
        }
        return segmentedControl
    }
}

extension UIImageView {

    class func create(image: UIImage? = nil, contentMode: UIView.ContentMode = .scaleAspectFit, clipToBounds: Bool = false, cornerRadius: CGFloat = 0, contentPriority axies: [NSLayoutConstraint.PriorityAxis] = []) -> UIImageView {

        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = clipToBounds
        imageView.layer.cornerRadius = cornerRadius
        imageView.contentMode = contentMode
        imageView.configureRequiredPriorities(for: axies)
        return imageView
    }
}

extension UITableView {

    enum ItemSizing {

        case automatic
        case strict(value: CGFloat)
    }

    class func create(style: UITableView.Style = .plain, rowSizing: ItemSizing = .automatic, sectionHeaderSizing: ItemSizing = .automatic) -> UITableView {

        let tableView = UITableView(frame: .zero, style: style)

        switch rowSizing {
        case .automatic:
            tableView.estimatedRowHeight = 40
            tableView.rowHeight = UITableView.automaticDimension
        case let .strict(value):
            tableView.estimatedRowHeight = value
        }

        switch sectionHeaderSizing {
        case .automatic:
            tableView.estimatedSectionHeaderHeight = 40
            tableView.sectionHeaderHeight = UITableView.automaticDimension
        case let .strict(value):
            tableView.sectionHeaderHeight = value
        }

        tableView.keyboardDismissMode = .onDrag
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        return tableView
    }
}

extension UICollectionView {

    enum ItemSizing {

        case automatic
        case strict(size: CGSize)
        case none
    }

    class func create(scrollingDirection: ScrollDirection, itemSizing: ItemSizing = .none, isPagingEnabled: Bool = false) -> UICollectionView {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0

        switch itemSizing {
        case .automatic:

            layout.itemSize = UICollectionViewFlowLayout.automaticSize
            layout.estimatedItemSize = CGSize(width: 300, height: 300)
        case let .strict(size):

            layout.itemSize = size
        case .none:

            break
        }

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = isPagingEnabled
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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

