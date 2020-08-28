//
//  PasswordMVPTemplate.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-27.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import Foundation

protocol PasswordViewPresenter {
    
    var passwordInfo: UpdatePasswordCall { get set }
    
    init(view: PasswordView)
    
    func updatePassword()
}

protocol PasswordView: class {
    
    func updatePassword(with state: LoadingState)
}
