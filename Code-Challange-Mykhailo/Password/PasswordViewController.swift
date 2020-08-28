//
//  PasswordViewController.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-27.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController, AlertPresentable {
    
    private enum Fields: Int {
        case current = 1, new, confirm
    }
    
    private let containerStackView = UIStackView.create(axis: .vertical, spacing: 16)
    
    private let currentPassTextField = UITextField.create(placeholder: NSLocalizedString("Current password", comment: "Text field placeholder"), isSecureEntry: true)
    private let newPassTextField = UITextField.create(placeholder: NSLocalizedString("New password", comment: "Text field placeholder"), isSecureEntry: true)
    private let confirmPassTextField = UITextField.create(placeholder: NSLocalizedString("Confirm password", comment: "Text field placeholder"), isSecureEntry: true)
    
    private var allTextFields: [UITextField] {
        return [currentPassTextField, newPassTextField, confirmPassTextField]
    }
    
    private let resetPassButton = UIButton.create(font: UIFont.preferredFont(forTextStyle: .body), text: NSLocalizedString("Reset Password", comment: "Button title"), textColor: .white, textAlignment: .center, backgroundColor: UIColor.mainTint, cornerRadius: 10)
    
    var presenter: PasswordViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NSLocalizedString("Reset password", comment: "Title of the view")
        view.backgroundColor = .white
        
        configureUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard allTextFields.contains(where: { $0.isFirstResponder }) else { return }
        self.view.endEditing(true)
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
        
        for (index, textField) in allTextFields.enumerated() {
            
            let label = UILabel.create(font: UIFont.preferredFont(forTextStyle: .caption1), text: labelNames[index])
            let separator = UIView.createSeparator()
            NSLayoutConstraint.size(view: separator, attributes: [.height(value: 0.5)])
            
            let stackView = UIStackView.create(axis: .vertical)
            stackView.items = [label, textField, separator]
            containerStackView.addArrangedSubview(stackView)
            
            textField.tag = index + 1
            textField.delegate = self
        }
        
        view.addSubview(containerStackView)
        NSLayoutConstraint.snap(containerStackView, to: view, for: [.topSafe, .left, .right], with: .create(vertical: 45, horizontal: 45))
    }
    
    private func configureButton() {
        
        resetPassButton.addTarget(self, action: #selector(handleResetPassword(button:)), for: .touchUpInside)
        resetPassButton.isEnabled = presenter.passwordInfo.isValid
        
        NSLayoutConstraint.size(view: resetPassButton, attributes: [.height(value: 50)])
        
        view.addSubview(resetPassButton)
        resetPassButton.topAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: 34).isActive = true
        NSLayoutConstraint.snap(resetPassButton, to: containerStackView, for: [.left, .right])
    }
    
    // MARK: Actions
    
    @objc private func handleResetPassword(button: UIButton) {
        
        self.view.endEditing(true)
        presenter.updatePassword()
    }
    
    // MARK: Login handling
    
    private func updateValue(with text: String, in textField: UITextField) {
        
        guard let field = Fields(rawValue: textField.tag) else { return }
        
        switch field {
        case .confirm:
            presenter.passwordInfo.passwordConfirmation = text
        case .new:
            presenter.passwordInfo.newPassword = text
        case .current:
            presenter.passwordInfo.currentPassword = text
        }
        
        resetPassButton.isEnabled = presenter.passwordInfo.isValid
    }
}

extension PasswordViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        updateValue(with: text, in: textField)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return true }
        updateValue(with: text, in: textField)
        return true
    }
}

extension PasswordViewController: PasswordView {
    
    func updatePassword(with state: LoadingState) {
        
        switch state {
        case .willLoad:

            LoaderView.shared.start(in: view)
        case .failLoading:
            
            LoaderView.shared.stop()
            presentAlert(title: NSLocalizedString("Failure", comment: "Alert title"), message: NSLocalizedString("Failed to updated password, try again.", comment: "Alert message"))
        case .didLoad:
            
            LoaderView.shared.stop()
            navigationController?.popViewController(animated: true)
        case .isLoading: break
        }
    }
}
