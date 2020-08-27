//
//  ProfilePresenter.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-26.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import Foundation

class ProfilePresenter: ProfileViewPresenter {
    
    unowned let view: ProfileView
    
    required init(view: ProfileView) {
        
        self.view = view
    }
    
}
