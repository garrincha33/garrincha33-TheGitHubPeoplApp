//
//  UserInfoController.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 22/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit


class UserInfoController: UIViewController {

    let headerView = UIView()
    //step 1 create 2 views and an array
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews: [UIView] = []
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        //step 4 refactor to methods
        configureViewController()
        setupUI()
        makeNetworkCallGetUserInfo()
    }

    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }

    private func makeNetworkCallGetUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let user):
                DispatchQueue.main.sync {
                    self.addChildVC(childVC: UIserInfoHeaderController(user: user), to: self.headerView)
                }
            case .failure(_):
                self.presentRPAlertOnMainThread(title: RPError.GHAlertMessageWrong.rawValue, message: RPError.GHAlertUnableTo.rawValue, buttonTitle: RPError.GHOKText.rawValue)
            }
        }
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    //step 2 refactor and add all views to array, padding and item height at top
    //also add contraints to item views array for the padding
    func setupUI() {
        let padding: CGFloat    = 20
        let itemHeight: CGFloat = 140
        
        itemViews = [headerView, itemViewOne, itemViewTwo]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        itemViewOne.backgroundColor = .systemPink
        itemViewTwo.backgroundColor = .systemBlue
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight)
        ])
    }

    private func addChildVC(childVC: UIViewController, to containterView: UIView) {
        addChild(childVC)
        containterView.addSubview(childVC.view)
        childVC.view.frame = containterView.bounds
        childVC.didMove(toParent: self)
    }
}
