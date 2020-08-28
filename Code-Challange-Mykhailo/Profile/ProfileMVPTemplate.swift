//
//  ProfileMVPTemplate.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-26.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import Foundation

protocol ProfileViewPresenter {
    
    var profile: Profile { get set }
    
    init(view: ProfileView)
    
    func loadProfile()
    func updateProfile()
}

protocol ProfileView: class {
    
    func loadingProfile(with state: LoadingState)
}
