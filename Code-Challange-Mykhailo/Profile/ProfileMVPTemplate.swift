//
//  ProfileMVPTemplate.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-26.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import Foundation

protocol ProfileViewPresenter {
    
    var profile: Profile { get }
    
    init(view: ProfileView)
    
//    func header(for section: LifeStyleSection) -> (title: String, annotation: String)
    
    func loadProfile()
//    func filterDisposableItems(query: String?)
}

protocol ProfileView: class {
    
    func loadingProfile(with state: LoadingState)
//    func refreshDisposableItems(animatingDifferences: Bool)
}
