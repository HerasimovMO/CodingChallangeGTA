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
    
    // MARK: Actions
    
    @objc private func handleProfileUpdate(button: UIButton) {
    
        self.view.endEditing(true)
        presenter.updateProfile()
    }
}

extension ProfileViewController: ProfileView {
    
    func loadingProfileInfo(with state: LoadingState) {
        
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
        
        guard let section = Section(rawValue: section) else { return nil }
        
        let footer: ProfileFooterView = tableView.dequeueReusableHeaderFooterView()
        
        switch section {
        case .basic:
            footer.handleUpdates = { [weak self] in
                self?.presenter.updateProfile()
            }
        case .password:
            footer.handleUpdates = { [weak self] in
                self?.presenter.updatePassword()
            }
        }
        
        return footer
    }
}
