//
//  UserInfoController.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 22/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit


class UserInfoController: UIViewController {

    //step 3 create a UIView to hold the info in a container view
    let headerView = UIView()
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        //step 5 call
        setupUI()
        print(username ?? "")
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let user):
                //step 7 add your child vc controller here
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
    //step 4 setup the UI and call
    private func setupUI() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
        ])
    }
    //step 6 setup your add child vc function
    private func addChildVC(childVC: UIViewController, to containterView: UIView) {
        addChild(childVC)
        containterView.addSubview(childVC.view)
        childVC.view.frame = containterView.bounds
        childVC.didMove(toParent: self)
    }
}
