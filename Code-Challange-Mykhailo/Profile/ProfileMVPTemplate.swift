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
}

protocol ProfileViewPresenter {
    
    var profile: Profile { get set }
    
    init(view: ProfileView)
    
    func loadProfile()
    func updateProfile()
    
    func header(for section: ProfileViewController.Section) -> String
    func item(for section: ProfileViewController.Section, field: ProfileViewController.Field) -> ProfileItem
}

protocol ProfileView: class {
    
    func loadingProfile(with state: LoadingState)
}
