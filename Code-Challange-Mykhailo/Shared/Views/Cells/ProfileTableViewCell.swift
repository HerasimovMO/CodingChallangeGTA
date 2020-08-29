//
//  ProfileTableViewCell.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-28.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    // MARK: - Insets & constants
    
    private let mainContentInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    private let height: CGFloat = 44
    
    // MARK: - Views
    
    private let contentStackView = UIStackView.create(axis: .horizontal, spacing: 5, distribution: .fillEqually)
    
    private let descriptionLabel = UILabel.create(font: UIFont.preferredFont(forTextStyle: .body), textAlignment: .left, contentPriority: [.horizontal(priority: .defaultLow)])
    private let valueTextField = UITextField.create(placeholder: NSLocalizedString("Enter username", comment: "Text field placeholder"))
    
    // MARK: - Properties
    
    private var textUpdate: ((_ text: String) -> Void)? = nil
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configureUI()
    }
    
    // MARK: - Configurations
    
    private func configureUI() {
    
        selectionStyle = .none
        valueTextField.delegate = self
        
        contentView.addSubview(contentStackView)
        NSLayoutConstraint.size(view: descriptionLabel, attributes: [.height(value: height)])
        NSLayoutConstraint.snap(contentStackView, to: contentView, for: [.bottom(priority: .defaultLow), .top, .left, .right], with: mainContentInsets)

        contentStackView.items = [descriptionLabel, valueTextField]
    }
    
    func update(with label: String, text: String = .empty) {
        
        descriptionLabel.text = label
        valueTextField.text = label
    }
}

extension ProfileTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
//        updateValue(with: text, in: textField)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return true }
//        updateValue(with: text, in: textField)
        return true
    }
}
