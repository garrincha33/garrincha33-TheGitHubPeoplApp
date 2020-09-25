//
//  UserInfoController.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 22/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

protocol UserInfoControllerDelegate: class {
    func didTapGitHubProfile(user: User)
    func didTapGetFollowers(user: User)
}

class UserInfoController: UIViewController {

    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLable = RPBodyLable(textAlignment: .center)
    var itemViews: [UIView] = []
    
    var username: String!
    weak var delegate: FollowerListControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
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
                    self.setupElements(with: user)
                }
            case .failure(_):
                self.presentRPAlertOnMainThread(title: RPError.GHAlertMessageWrong.rawValue, message: RPError.GHAlertUnableTo.rawValue, buttonTitle: RPError.GHOKText.rawValue)
            }
        }
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }

    private func setupElements(with user: User) {
        let repoItemController = RPRepoItemController(user: user)
        repoItemController.delegate = self
        let followerItemController = RPFollowerItemController(user: user)
        followerItemController.delegate = self
        
        self.addChildVC(childVC: UIserInfoHeaderController(user: user), to: self.headerView)
        self.addChildVC(childVC: repoItemController, to: self.itemViewOne)
        self.addChildVC(childVC: followerItemController, to: self.itemViewTwo)
        self.dateLable.text = "GitHub member since \(user.createdAt.convertToDisplayFormat())"
    }
    
    private func setupUI() {
        let padding: CGFloat    = 20
        let itemHeight: CGFloat = 140
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLable]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
  
            dateLable.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLable.heightAnchor.constraint(equalToConstant: 18)
        ])
    }

    private func addChildVC(childVC: UIViewController, to containterView: UIView) {
        addChild(childVC)
        containterView.addSubview(childVC.view)
        childVC.view.frame = containterView.bounds
        childVC.didMove(toParent: self)
    }
}

extension UserInfoController: UserInfoControllerDelegate {
    func didTapGitHubProfile(user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentRPAlertOnMainThread(title: "Invalid URL", message: "The url is invalid", buttonTitle: RPError.GHOKText.rawValue)
            return
        }
        presentSafariController(with: url)
    }

    func didTapGetFollowers(user: User) {
        guard user.followers != 0 else {
            presentRPAlertOnMainThread(title: "User has no followers", message: "no followers", buttonTitle: RPError.GHOKText.rawValue)
            return
        }
        delegate.didTapGetFollowers(username: user.login)
        dismissVC()
    }
}
