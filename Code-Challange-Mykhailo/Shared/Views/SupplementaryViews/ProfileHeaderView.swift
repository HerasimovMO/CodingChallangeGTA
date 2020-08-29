//
//  ProfileHeaderView.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-28.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureUI()
    }
    
    // MARK: - Configurations
    
    private func configureUI() {}

}
