//
//  ProfileViewController.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-26.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, AlertPresentable {
    
    private let containerStackView = UIStackView.create(axis: .vertical, spacing: 16)
    
    private let usernameTextField = UITextField.create(placeholder: NSLocalizedString("Enter username", comment: "Text field placeholder"))
    private let firstNameTextField = UITextField.create(placeholder: NSLocalizedString("Enter first name", comment: "Text field placeholder"))
    private let lastNameTextField = UITextField.create(placeholder: NSLocalizedString("Enter last name", comment: "Text field placeholder"))
    
    private var allTextFields: [UITextField] {
        return [usernameTextField, firstNameTextField, lastNameTextField]
    }
    
    var presenter: ProfileViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NSLocalizedString("Profile", comment: "Title of the view")
        view.backgroundColor = .white
        
        configureUI()
        presenter.loadProfile()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard allTextFields.contains(where: { $0.isFirstResponder }) else { return }
        self.view.endEditing(true)
    }
    
    // MARK: UI configuration
    
    private func configureUI() {
        
        configureTextFields()
        configureButtons()
    }
    
    private func configureTextFields() {
        
        let labelNames = [NSLocalizedString("Username", comment: "Label for the text field"),
                          NSLocalizedString("First name", comment: "Label for the text field"),
                          NSLocalizedString("Last name", comment: "Label for the text field")]
        
        for (index, textField) in allTextFields.enumerated() {
            
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
    
    private func configureButtons() {
        
        let stackView = UIStackView.create(axis: .vertical, spacing: 0)
        
        let saveButtonText = NSLocalizedString("Save Changes", comment: "Button title")
        let saveButton = UIButton.create(font: UIFont.preferredFont(forTextStyle: .body), text: saveButtonText, textColor: .white, textAlignment: .center, backgroundColor: UIColor.mainTint, cornerRadius: 10)
        saveButton.addTarget(self, action: #selector(handleProfileUpdate(button:)), for: .touchUpInside)
        
        let resetPassButtonText = NSLocalizedString("Reset Password", comment: "Button title")
        let resetPassButton = UIButton.create(font: UIFont.preferredFont(forTextStyle: .footnote), text: resetPassButtonText, textColor: UIColor.mainTint, textAlignment: .center)
        resetPassButton.addTarget(self, action: #selector(handleResetPassword(button:)), for: .touchUpInside)
        
        NSLayoutConstraint.size(view: resetPassButton, attributes: [.height(value: 44)])
        NSLayoutConstraint.size(view: saveButton, attributes: [.height(value: 50)])
        
        stackView.items = [saveButton, resetPassButton]
        view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: 34).isActive = true
        NSLayoutConstraint.snap(stackView, to: containerStackView, for: [.left, .right])
    }
    
    // MARK: Actions
    
    @objc private func handleProfileUpdate(button: UIButton) {
        
        print("handle profile update")
    }
    
    @objc private func handleResetPassword(button: UIButton) {
        
        let passwordResetViewController = PasswordViewController()
        passwordResetViewController.presenter = PasswordPresenter(view: passwordResetViewController)
        
        navigationController?.pushViewController(passwordResetViewController, animated: true)
    }
}

extension ProfileViewController: ProfileView {
    
    func loadingProfile(with state: LoadingState) {
        
        switch state {
        case .willLoad:

            LoaderView.shared.start(in: view)
        case .failLoading:
            
            LoaderView.shared.stop()
            presentAlert(title: NSLocalizedString("Failure", comment: "Alert title"), message: NSLocalizedString("Failed to load profile", comment: "Alert message"))
        case .didLoad:
            
            LoaderView.shared.stop()
            
            usernameTextField.text = presenter.profile.userName
            firstNameTextField.text = presenter.profile.firstName
            lastNameTextField.text = presenter.profile.lastName
        case .isLoading: break
        }
    }
}
