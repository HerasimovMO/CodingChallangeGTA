//
//  ProfileViewController.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-26.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, AlertPresentable {
    
    enum Field {
        case username, firstname, lastname, newPass, confirmPass
    }

    enum Section: Int, CaseIterable {
        case basic, password
        
        var items: [Field] {
            switch self {
            case .basic:
                return [.username, .firstname, .lastname]
            case .password:
                return [.newPass, .confirmPass]
            }
        }
    }
    
    private let contentInset = UIEdgeInsets.create(top: 25)
    
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
    
//    private let saveButton = UIButton.create(font: UIFont.preferredFont(forTextStyle: .body), text: NSLocalizedString("Save Changes", comment: "Button title"), textColor: .white, textAlignment: .center, backgroundColor: UIColor.mainTint, cornerRadius: 10)
    
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
    
    // MARK: UI configuration
    
    private func configureUI() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.contentInset = contentInset
        tableView.register(ProfileTableViewCell.self)
        tableView.register(ProfileHeaderView.self)
        tableView.register(ProfileFooterView.self)
        
        view.addSubview(tableView)
        NSLayoutConstraint.snap(tableView, to: view)
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
    
    // MARK: Logic handling
    
    private func updateValue(with text: String, in textField: UITextField) {
        
//        guard let field = Fields(rawValue: textField.tag) else { return }
//
//        switch field {
//        case .username:
//            presenter.profile.userName = text
//        case .lastname:
//            presenter.profile.lastName = text
//        case .firstname:
//            presenter.profile.firstName = text
//        }
//
//        saveButton.isEnabled = presenter.profile.isValid
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
            tableView.reloadData()
        case .isLoading: break
        }
    }
}

// MARK: - TableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Section.allCases[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = Section(rawValue: indexPath.section),
              let field = section.items[safe: indexPath.row] else {
                
            return UITableViewCell()
        }
        
        let cell: ProfileTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.update(with: presenter.item(for: section, field: field)) { [weak self] in
            self?.presenter.updateItem(with: $0, for: section, field: field)
        }
        
        return cell
    }
}

// MARK: - TableViewDataDelegate

extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let section = Section(rawValue: section) else { return nil }
              
        let header: ProfileHeaderView = tableView.dequeueReusableHeaderFooterView()
        header.update(title: presenter.header(for: section))
        return header
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer: ProfileFooterView = tableView.dequeueReusableHeaderFooterView()
        return footer
    }
}
