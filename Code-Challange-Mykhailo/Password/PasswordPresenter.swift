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
            view.updatePassword(with: loadState)
        }
    }
    
    var passwordInfo: UpdatePasswordCall
    
    unowned let view: PasswordView
    
    required init(view: PasswordView) {
        
        self.view = view
        self.passwordInfo = UpdatePasswordCall()
    }
    
    // API requests
    
    func updatePassword() {
        
        loadState = .willLoad
        loadState = .isLoading
        
        APIClient().updatePassword(call: passwordInfo) { [weak self] response in
            
            guard let self = self else { return }
            
            switch response {
            case .failure:
                self.loadState = .failLoading
            case .success:
                self.loadState = .didLoad
            }
        }
    }
}
