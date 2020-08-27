//
//  PasswordViewController.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-27.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {
    
    let containerStackView = UIStackView.create(axis: .vertical, spacing: 16)
    
    let currentPassTextField = UITextField.create(placeholder: NSLocalizedString("Current password", comment: "Text field placeholder"))
    let newPassTextField = UITextField.create(placeholder: NSLocalizedString("New password", comment: "Text field placeholder"))
    let confirmPassTextField = UITextField.create(placeholder: NSLocalizedString("Confirm password", comment: "Text field placeholder"))
    
    var presenter: PasswordViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NSLocalizedString("Reset password", comment: "Title of the view")
        view.backgroundColor = .white
        
        configureUI()
    }
    
    func configureUI() {
        
        configureTextFields()
    }
    
    func configureTextFields() {
        
        let labelNames = [NSLocalizedString("Enter current password", comment: "Label for the text field"),
                          NSLocalizedString("Enter new password", comment: "Label for the text field"),
                          NSLocalizedString("Confirm entered password", comment: "Label for the text field")]
        
        for (index, textField) in [currentPassTextField, newPassTextField, confirmPassTextField].enumerated() {
            
            let label = UILabel.create(font: UIFont.preferredFont(forTextStyle: .caption1), text: labelNames[index])
            let separator = UIView.createSeparator()
            NSLayoutConstraint.size(view: separator, attributes: [.height(value: 0.5)])
            
            let stackView = UIStackView.create(axis: .vertical)
            stackView.items = [label, textField, separator]
            containerStackView.addArrangedSubview(stackView)
        }
        
        view.addSubview(containerStackView)
        NSLayoutConstraint.snap(containerStackView, to: view, for: [.topSafe, .left, .right], with: .create(vertical: 45, horizontal: 45))
    }
    
    
}

extension PasswordViewController: PasswordView {}
