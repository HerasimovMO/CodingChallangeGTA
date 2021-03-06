//
//  AutoLayout+ConvenientHelpers.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-27.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    enum Side: CaseIterable, Hashable, Equatable {
        
        static let top: Side = .top(priority: .required)
        static let bottom: Side = .bottom(priority: .required)
        static let left: Side = .left(priority: .required)
        static let right: Side = .right(priority: .required)
        static let topSafe: Side = .topSafe(priority: .required)
        
        case top(priority: UILayoutPriority)
        case bottom(priority: UILayoutPriority)
        case left(priority: UILayoutPriority)
        case right(priority: UILayoutPriority)
        case topSafe(priority: UILayoutPriority)
        
        static let allCases: [Side] = [.top, .bottom, .left, .right]
        
        func hash(into hasher: inout Hasher) {
            guard let index = (Side.allCases + [.topSafe]).firstIndex(of: self) else { return }
            hasher.combine(index)
        }
        
        static func == (lhs: Side, rhs: Side) -> Bool {
            switch (lhs, rhs) {
            case let (.top(lhsPriority), .top(rhsPriority)),
                 let (.bottom(lhsPriority), .bottom(rhsPriority)),
                 let (.left(lhsPriority), .left(rhsPriority)),
                 let (.right(lhsPriority), .right(rhsPriority)),
                 let (.topSafe(lhsPriority), .topSafe(rhsPriority)):
                return lhsPriority == rhsPriority
            default:
                return false
            }
        }
    }
    
    enum PriorityAxis {
        
        static let horizontal: PriorityAxis = .horizontal(priority: .required)
        static let vertical: PriorityAxis = .vertical(priority: .required)
        
        case horizontal(priority: UILayoutPriority)
        case vertical(priority: UILayoutPriority)
        
        var constraintAxis: Axis {
            switch self {
            case .horizontal:
                return .horizontal
            case .vertical:
                return .vertical
            }
        }
    }
    
    @discardableResult
    static func snap(_ subview: UIView, to view: UIView, for sides: [Side] = Side.allCases, sizeAttributes: [CGSize.Attributes] = [], with inset: UIEdgeInsets = .zero) -> [Side: NSLayoutConstraint] {
        
        var constraints: [Side: NSLayoutConstraint] = [:]
        
        for side in sides {
            switch side {
            case let .topSafe(priority):
                constraints[side] = subview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset.top).activate(with: priority)
            case let .top(priority):
                constraints[side] = subview.topAnchor.constraint(equalTo: view.topAnchor, constant: inset.top).activate(with: priority)
            case let .bottom(priority):
                constraints[side] = subview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -inset.bottom).activate(with: priority)
            case let .left(priority):
                constraints[side] = subview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: inset.left).activate(with: priority)
            case let .right(priority):
                constraints[side] = subview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -inset.right).activate(with: priority)
            }
        }
        
        size(view: view, attributes: sizeAttributes)
        return constraints
    }
    
    static func size(view: UIView, attributes: [CGSize.Attributes]) {
        
        for attribute in attributes {
            switch attribute {
            case let .width(value):
                view.widthAnchor.constraint(equalToConstant: value).isActive = true
            case let .height(value):
                view.heightAnchor.constraint(equalToConstant: value).isActive = true
            }
        }
    }
    
    static func center(_ subview: UIView, in view: UIView, for axises: [Axis] = [.vertical, .horizontal], with offset: CGPoint = .zero) {
        
        for axis in axises {
            switch axis {
            case .vertical:
                subview.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offset.y).isActive = true
            case .horizontal:
                subview.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: offset.x).isActive = true
            @unknown default:
                fatalError()
            }
        }
    }
    
    @discardableResult
    func activate(with priority: UILayoutPriority) -> NSLayoutConstraint {
        
        self.priority = priority
        isActive = true
        return self
    }
}

extension UIEdgeInsets {
    
    static func create(top: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    static func create(vertical: CGFloat, horizontal: CGFloat) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}

extension CGSize {
    
    enum Attributes {
        
        case width(value: CGFloat)
        case height(value: CGFloat)
    }
}

