//
//  ProfileFooterView.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-28.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class ProfileFooterView: UITableViewHeaderFooterView {
    
    // MARK: Insets & constants
    
    private let contentHeight: CGFloat = 86
    private let buttonSize: [CGSize.Attributes] = [.height(value: 36), .width(value: 168)]
    
    // MARK: Views
    
    private let containerView = UIView.createEmpty(backgroundColor: .reddish)
    private let saveButton = UIButton.create(font: UIFont.systemFont(ofSize: 14, weight: .semibold), text: NSLocalizedString("SAVE CHANGES", comment: "Button title"), textColor: .white, textAlignment: .center, borderWidth: 1, borderColor: .white, cornerRadius: 5)
    
    // MARK: Properties
    
    var handleUpdates: (() -> Void)? = nil
    
    // MARK: Initializers
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureUI()
    }
    
    // MARK: Configurations
    
    private func configureUI() {
        
        saveButton.addTarget(self, action: #selector(handleUpdate(button:)), for: .touchUpInside)
        
        contentView.addSubview(containerView)
        containerView.addSubview(saveButton)
        
        NSLayoutConstraint.size(view: containerView, attributes: [.height(value: contentHeight)])
        NSLayoutConstraint.size(view: saveButton, attributes: buttonSize)
        
        NSLayoutConstraint.center(saveButton, in: containerView)
        NSLayoutConstraint.snap(containerView, to: contentView, for: [.bottom(priority: .defaultLow), .top, .left, .right])
    }
    
    // MARK: Logic
    
    @objc private func handleUpdate(button: UIButton) {
        handleUpdates?()
    }
}
