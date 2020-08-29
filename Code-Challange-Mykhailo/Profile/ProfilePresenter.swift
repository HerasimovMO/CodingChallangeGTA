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
    
    // MARK: Content provider
    
    func header(for section: ProfileViewController.Section) -> String {
        switch section {
        case .basic:
            return NSLocalizedString("BASIC INFORMATION", comment: "Section header")
        case .password:
            return NSLocalizedString("PASSWORD", comment: "Section header")
        }
    }
    
    func item(for section: ProfileViewController.Section, field: ProfileViewController.Field) -> ProfileItem {
        switch field {
        case .username:
            return ProfileItem(label: NSLocalizedString("Username", comment: "Label for the text field"),
                               content: profile.userName,
                               placeholder: NSLocalizedString("Enter username", comment: "Text field placeholder"))
        case .firstname:
            return ProfileItem(label:  NSLocalizedString("First name", comment: "Label for the text field"),
                               content: profile.firstName,
                               placeholder: NSLocalizedString("Enter first name", comment: "Text field placeholder"))
        case .lastname:
            return ProfileItem(label: NSLocalizedString("Last name", comment: "Label for the text field"),
                               content: profile.lastName,
                               placeholder: NSLocalizedString("Enter last name", comment: "Text field placeholder"))
        case .newPass:
            return ProfileItem(label: NSLocalizedString("New Password", comment: "Label for the text field"),
                               content: .empty,
                               placeholder: .empty)//NSLocalizedString("Enter new password", comment: "Text field placeholder"))
        case .confirmPass:
            return ProfileItem(label: NSLocalizedString("Re-entered Password", comment: "Label for the text field"),
                               content: .empty,
                               placeholder: .empty)//NSLocalizedString("Re-entered password", comment: "Text field placeholder"))
        }
    }
}
