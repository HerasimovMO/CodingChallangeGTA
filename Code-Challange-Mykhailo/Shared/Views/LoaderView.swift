//
//  LoaderView.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-27.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class LoaderView: UIView {
    
    static let shared = LoaderView()
    
    private var sideConstraints: [NSLayoutConstraint] = []
    private let indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.hidesWhenStopped = true
        view.tintColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        translatesAutoresizingMaskIntoConstraints = false
    
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(blurEffectView)
        NSLayoutConstraint.snap(blurEffectView, to: self)
        
        addSubview(indicator)
        NSLayoutConstraint.center(indicator, in: self)
    }
    
    func start(in view: UIView) {
        guard superview == nil else { return }
        view.addSubview(self)
        sideConstraints = Array(NSLayoutConstraint.snap(self, to: view, for: [.left, .right, .bottom, .topSafe]).values)
        indicator.startAnimating()
    }
    
    func stop() {
        indicator.stopAnimating()
        removeConstraints(sideConstraints)
        removeFromSuperview()
    }
}
