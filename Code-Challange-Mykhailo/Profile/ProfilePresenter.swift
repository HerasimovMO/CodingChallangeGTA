//
//  ProfilePresenter.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-26.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import Foundation

class ProfilePresenter: ProfileViewPresenter {
    
    private var loadState: LoadingState = .didLoad {
        didSet {
            view.loadingProfile(with: loadState)
        }
    }
    
    var profile: Profile
    
    unowned let view: ProfileView
    
    required init(view: ProfileView) {
        
        self.view = view
        self.profile = Profile()
    }
    
    // API requests
    
    func loadProfile() {
        
        loadState = .willLoad
        loadState = .isLoading
        
        APIClient().getProfile { [weak self] response in
            
            guard let self = self else { return }
            
            guard let profile = response.value?.data else {
                
                self.loadState = .failLoading(message: NSLocalizedString("Failed to load profile", comment: "Alert message"))
                return
            }
            
            self.profile = profile
            self.loadState = .didLoad
        }
    }
    
    func updateProfile() {
        
        loadState = .willLoad
        loadState = .isLoading
        
        APIClient().updateProfile(profile: profile) { [weak self] response in
            
            guard let self = self else { return }
            
            guard let profile = response.value?.data else {
                
                self.loadState = .failLoading(message: NSLocalizedString("Failed to update profile, try again", comment: "Alert message"))
                return
            }
            
            self.profile = profile
            self.loadState = .didLoad
        }
    }
}
