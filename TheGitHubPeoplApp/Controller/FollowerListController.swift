//
//  FollowerListController.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 17/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

class FollowerListController: UIViewController {

    //step 1 create a colelction view
    var collectionView: UICollectionView!
    var username: String?
    fileprivate let padding: CGFloat = 16

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        makeNetworkCall()
        configureCollectionViewController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //step 2 configure collectionView
    private func configureCollectionViewController() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink
        collectionView.register(CustomFollowerCell.self, forCellWithReuseIdentifier: CustomFollowerCell.reuseIdentifier)
    }

    
    private func makeNetworkCall() {
        NetworkManager.shared.getFollowers(for: username ?? RPError.RPNetworkErrorUserMessage.rawValue, page: 1) { result in
            switch result {
            case .success(let followers):
                print(followers)
            case .failure(let error):
                self.presentRPAlertOnMainThread(title: RPError.GHAlertMessageWrong.rawValue, message: error.rawValue, buttonTitle: RPError.GHOKText.rawValue)
            }
        }
    }
}
