//
//  PasswordMVPTemplate.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-27.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import Foundation

protocol PasswordViewPresenter {
    
//    var profile: Profile { get }
    
    init(view: PasswordView)
    
//    func header(for section: LifeStyleSection) -> (title: String, annotation: String)
    
//    func loadProfile()
//    func filterDisposableItems(query: String?)
}

protocol PasswordView: class {
    
//    func loadingProfile(with state: LoadingState)
//    func refreshDisposableItems(animatingDifferences: Bool)
}
