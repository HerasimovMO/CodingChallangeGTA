//
//  ProfileHeaderView.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-28.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Insets & constants

    private let mainContentInsets = UIEdgeInsets.create(vertical: 0, horizontal: 16)
    private let height: CGFloat = 30
    
    // MARK: - Views
    
    private let titleLabel = UILabel.create(font: UIFont.preferredFont(forTextStyle: .footnote), textColor: .gray, textAlignment: .left, contentPriority: [.horizontal(priority: .defaultLow)])
    
    // MARK: - Initializers

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureUI()
    }
    
    // MARK: - Configurations
    
    private func configureUI() {
        
        contentView.backgroundColor = UIColor.veryLightGray
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.size(view: titleLabel, attributes: [.height(value: height)])
        NSLayoutConstraint.snap(titleLabel, to: contentView, for: [.bottom(priority: .defaultLow), .top, .left, .right], with: mainContentInsets)
    }
    
    func update(title: String) {
        
        titleLabel.text = title
    }
}
