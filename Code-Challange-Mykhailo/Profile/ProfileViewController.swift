//
//  ProfileViewController.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-26.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, AlertPresentable {
    
    private enum Fields: Int {
        case username = 1, firstname, lastname
    }
    
    // MARK: UI items
    
    private let tableView = UITableView.create(style: .grouped, backgroundColor: UIColor.reddish)
    
//    private let containerStackView = UIStackView.create(axis: .vertical, spacing: 16)
//
//    private let usernameTextField = UITextField.create(placeholder: NSLocalizedString("Enter username", comment: "Text field placeholder"))
//    private let firstNameTextField = UITextField.create(placeholder: NSLocalizedString("Enter first name", comment: "Text field placeholder"))
//    private let lastNameTextField = UITextField.create(placeholder: NSLocalizedString("Enter last name", comment: "Text field placeholder"))
//
//    private var allTextFields: [UITextField] {
//        return [usernameTextField, firstNameTextField, lastNameTextField]
//    }
    
    private let saveButton = UIButton.create(font: UIFont.preferredFont(forTextStyle: .body), text: NSLocalizedString("Save Changes", comment: "Button title"), textColor: .white, textAlignment: .center, backgroundColor: UIColor.mainTint, cornerRadius: 10)
    
    var presenter: ProfileViewPresenter!
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NSLocalizedString("User Profile", comment: "Title of the view")
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureUI()
        presenter.loadProfile()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        guard allTextFields.contains(where: { $0.isFirstResponder }) else { return }
//        self.view.endEditing(true)
    }
    
    // MARK: UI configuration
    
    private func configureUI() {
        
        tableView.register(ProfileTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        NSLayoutConstraint.snap(tableView, to: view)

        
//        configureTextFields()
//        configureButtons()
    }
    
//    private func configureTextFields() {
//
//        let labelNames = [NSLocalizedString("Username", comment: "Label for the text field"),
//                          NSLocalizedString("First name", comment: "Label for the text field"),
//                          NSLocalizedString("Last name", comment: "Label for the text field")]
//
//        for (index, textField) in allTextFields.enumerated() {
//
//            let label = UILabel.create(font: UIFont.preferredFont(forTextStyle: .caption1), text: labelNames[index])
//            let separator = UIView.createSeparator()
//            NSLayoutConstraint.size(view: separator, attributes: [.height(value: 0.5)])
//
//            let stackView = UIStackView.create(axis: .vertical)
//            stackView.items = [label, textField, separator]
//            containerStackView.addArrangedSubview(stackView)
//
//            textField.tag = index + 1
//            textField.delegate = self
//        }
//
//        view.addSubview(containerStackView)
//        NSLayoutConstraint.snap(containerStackView, to: view, for: [.topSafe, .left, .right], with: .create(vertical: 45, horizontal: 45))
//    }
//
//    private func configureButtons() {
//
//        let stackView = UIStackView.create(axis: .vertical, spacing: 0)
//
//        saveButton.addTarget(self, action: #selector(handleProfileUpdate(button:)), for: .touchUpInside)
//
//        let resetPassText = NSLocalizedString("Reset Password", comment: "Button title")
//        let resetPassButton = UIButton.create(font: UIFont.preferredFont(forTextStyle: .footnote), text: resetPassText, textColor: UIColor.mainTint, textAlignment: .center)
//        resetPassButton.addTarget(self, action: #selector(handleResetPassword(button:)), for: .touchUpInside)
//
//        NSLayoutConstraint.size(view: resetPassButton, attributes: [.height(value: 44)])
//        NSLayoutConstraint.size(view: saveButton, attributes: [.height(value: 50)])
//
//        stackView.items = [saveButton, resetPassButton]
//        view.addSubview(stackView)
//
//        stackView.topAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: 34).isActive = true
//        NSLayoutConstraint.snap(stackView, to: containerStackView, for: [.left, .right])
//    }
    
    // MARK: Actions
    
    @objc private func handleProfileUpdate(button: UIButton) {
    
        self.view.endEditing(true)
        presenter.updateProfile()
    }
    
    @objc private func handleResetPassword(button: UIButton) {
        
        let passwordResetViewController = PasswordViewController()
        passwordResetViewController.presenter = PasswordPresenter(view: passwordResetViewController)
        
        navigationController?.pushViewController(passwordResetViewController, animated: true)
    }
    
    // MARK: Logic handling
    
    private func updateValue(with text: String, in textField: UITextField) {
        
        guard let field = Fields(rawValue: textField.tag) else { return }
        
        switch field {
        case .username:
            presenter.profile.userName = text
        case .lastname:
            presenter.profile.lastName = text
        case .firstname:
            presenter.profile.firstName = text
        }
        
        saveButton.isEnabled = presenter.profile.isValid
    }
}

extension ProfileViewController: UITextFieldDelegate {
    
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

extension ProfileViewController: ProfileView {
    
    func loadingProfile(with state: LoadingState) {
        
        switch state {
        case .willLoad:
            
            LoaderView.shared.start(in: view)
        case let .failLoading(message):
            
            LoaderView.shared.stop()
            presentAlert(title: NSLocalizedString("Failure", comment: "Alert title"), message: message)
        case .didLoad:
            
            LoaderView.shared.stop()
            
//            usernameTextField.text = presenter.profile.userName
//            firstNameTextField.text = presenter.profile.firstName
//            lastNameTextField.text = presenter.profile.lastName
        case .isLoading: break
        }
    }
}

// MARK: - TableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let sectionModel: HierarchicalViewModelType = viewModel.sectionItem(at: section) else {
//            Logger.debug("no item at section: \(section)")
//            return 0
//        }
//
//        return sectionModel.numberOfItems
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ProfileTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        
//        guard let sectionModel = viewModel.sectionItem(at: indexPath.section), let itemModel = sectionModel.item(at: indexPath.row) as? HierarchicalCellRepresentableViewModelType else {
//            Logger.debug("no item at indexPath : \(indexPath)")
//            return UITableViewCell()
//        }

        cell.update(with: "Value", text: "Value")
        return cell
    }
}

// MARK: - TableViewDataDelegate

extension ProfileViewController: UITableViewDelegate {

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let sectionModel = viewModel.sectionItem(at: indexPath.section) as? HierarchicalCellRepresentableViewModelType else {
//            Logger.debug("no item at indexPath : \(indexPath)")
//            return
//        }
//
//        sectionModel.selectItem(atIndex: indexPath.row)
//    }

//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return section == 0 ? CGFloat.leastNonzeroMagnitude : 10.0
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return CGFloat.leastNonzeroMagnitude
//    }

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return UIView.createEmpty(backgroundColor: Theme.beigeColor)
//    }

//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        return UIView.createEmpty()
//    }
}
