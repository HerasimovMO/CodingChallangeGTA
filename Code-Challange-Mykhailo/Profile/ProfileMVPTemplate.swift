//
//  ProfileMVPTemplate.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-26.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import Foundation

struct ProfileItem {
    
    let label: String
    let content: String
    let placeholder: String
    let isSecure: Bool
    
    init(label: String, content: String, placeholder: String, isSecure: Bool = false) {
        
        self.label = label
        self.content = content
        self.placeholder = placeholder
        self.isSecure = isSecure
    }
}

protocol ProfileViewPresenter {
    
    init(view: ProfileView)
    
    func loadProfile()
    func updateProfile()
    func updatePassword()
    
    func header(for section: ProfileViewController.Section) -> String
    func item(for section: ProfileViewController.Section, field: ProfileViewController.Field) -> ProfileItem
    
    func updateItem(with text: String, for section: ProfileViewController.Section, field: ProfileViewController.Field)
}

protocol ProfileView: class {
    
    func loadingProfileInfo(with state: LoadingState)
}
