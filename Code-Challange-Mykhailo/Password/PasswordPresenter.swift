//
//  PasswordPresenter.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-27.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import Foundation

class PasswordPresenter: PasswordViewPresenter {
    
    private var loadState: LoadingState = .didLoad {
        didSet {
//            view.loadingProfile(with: loadState)
        }
    }
    
    unowned let view: PasswordView
    
    required init(view: PasswordView) {
        
        self.view = view
//        self.profile = Profile()
    }
    
    // API requests
    
//    func loadProfile() {
//
//        loadState = .willLoad
//        loadState = .isLoading
//
//        APIClient().getProfile { [weak self] response in
//
//            guard let self = self else { return }
//
//            guard let profile = response.value?.data else {
//
//                self.loadState = .failLoading
//                return
//            }
//
//            self.profile = profile
//            self.loadState = .didLoad
//        }
//    }
}
