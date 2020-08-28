//
//  AlertPresentable.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-27.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import Foundation

import UIKit

protocol AlertPresentable {
    func presentAlert(title: String?, message: String?, actions: [UIAlertAction], alertStyle: UIAlertController.Style, handler: (() -> Void)?)
}

extension AlertPresentable where Self: UIViewController {

    func presentAlert(title: String?, message: String?, actions: [UIAlertAction] = [.ok], alertStyle: UIAlertController.Style = .alert, handler: (() -> Void)? = nil) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)

        actions.forEach { alert.addAction($0) }

        present(alert, animated: true, completion: handler)
    }
}
