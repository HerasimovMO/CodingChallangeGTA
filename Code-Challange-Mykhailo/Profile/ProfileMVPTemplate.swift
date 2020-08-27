//
//  ProfileMVPTemplate.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-26.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import Foundation

protocol ProfileViewPresenter {
    
//    var disposableItems: [(section: LifeStyleSection, items: [DisposableItem])] { get }
    
    init(view: ProfileView)
    
//    func header(for section: LifeStyleSection) -> (title: String, annotation: String)
    
//    func loadItems(isReloading: Bool, selectedWeek: (week: Int, date: Date)?)
//    func filterDisposableItems(query: String?)
}

protocol ProfileView: class {
    
//    func loadingDisposableItems(with info: LoadInfo)
//    func refreshDisposableItems(animatingDifferences: Bool)
}
