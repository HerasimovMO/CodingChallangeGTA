//
//  ProfileViewController.swift
//  Code-Challange-Mykhailo
//
//  Created by Mykhailo Herasimov on 2020-08-26.
//  Copyright © 2020 Mykhailo Herasimov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var presenter: ProfileViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .blue
    }
    
    
}

extension ProfileViewController: ProfileView {
    
    func loadingProfile(with state: LoadingState) {
        
        switch state {
        case .willLoad:
//            guard info.type == .loadNew else { break }
            break
            //                  LoaderView.shared.start(in: view) { [weak self] in
            //                      guard let self = self else { return }
            //                      view.insertSubview($0, aboveSubview: self.collectionView)
        //                  }
        case .failLoading:
            //                  LoaderView.shared.stop()
            //                  refreshControl.endRefreshing()
            //                  configureBackgroundView(for: .error)
            break
        case .didLoad:
            //                  LoaderView.shared.stop()
            //                  refreshControl.endRefreshing()
            //                  refreshDisposableItems(animatingDifferences: true)
            print(presenter.profile)
        case .isLoading: break
        }
    }
}
