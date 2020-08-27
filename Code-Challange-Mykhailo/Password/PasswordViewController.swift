//
//  PasswordViewController.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-27.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {
    
    private let containerStackView = UIStackView.create(axis: .vertical, spacing: 16)
    
    private let currentPassTextField = UITextField.create(placeholder: NSLocalizedString("Current password", comment: "Text field placeholder"))
    private let newPassTextField = UITextField.create(placeholder: NSLocalizedString("New password", comment: "Text field placeholder"))
    private let confirmPassTextField = UITextField.create(placeholder: NSLocalizedString("Confirm password", comment: "Text field placeholder"))
    
    var presenter: PasswordViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NSLocalizedString("Reset password", comment: "Title of the view")
        view.backgroundColor = .white
        
        configureUI()
    }
    
    // MARK: UI configuration
    
    private func configureUI() {
        
        configureTextFields()
        configureButton()
    }
    
    private func configureTextFields() {
        
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
    
    private func configureButton() {
        
        let resetPassButtonText = NSLocalizedString("Reset Password", comment: "Button title")
        let resetPassButton = UIButton.create(font: UIFont.preferredFont(forTextStyle: .body), text: resetPassButtonText, textColor: .white, textAlignment: .center, backgroundColor: UIColor.mainTint, cornerRadius: 10)
        resetPassButton.addTarget(self, action: #selector(handleResetPassword(button:)), for: .touchUpInside)
        
        NSLayoutConstraint.size(view: resetPassButton, attributes: [.height(value: 50)])
        
        view.addSubview(resetPassButton)
        resetPassButton.topAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: 34).isActive = true
        NSLayoutConstraint.snap(resetPassButton, to: containerStackView, for: [.left, .right])
    }
    
    // MARK: Actions
    
    @objc private func handleResetPassword(button: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
}

extension PasswordViewController: PasswordView {}
