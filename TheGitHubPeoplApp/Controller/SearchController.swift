//
//  SearchController.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 16/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit


class SearchController: UIViewController {

    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ControllerItem.GHLogo)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let usernameTextField = RPUITextfield()
    let CallToActionButton = RPUIButton(backgroundColor: .systemGreen, title: ControllerItem.GHButtonText)
    var isUsernameEntered: Bool {return !usernameTextField.text!.isEmpty}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupUI()
        dismissKeyboardTap()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    private func dismissKeyboardTap() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    
    
    @objc private func gotoFollowerController() {
        guard isUsernameEntered else {
            //step 12 - call your new alert
            presentRPAlertOnMainThread(title: ControllerItem.GHAlertEmpty, message: ControllerItem.GHAlertMessageUsername, buttonTitle: ControllerItem.GHOKText)
            return
        }
        
        let controller = FollowerListController()
        controller.username = usernameTextField.text
        controller.title = usernameTextField.text
        navigationController?.pushViewController(controller, animated: true)
    }

    private func setupUI() {
        //MARK:- Logo
        view.addSubview(logoImageView)
        logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        //MARK:- TextField
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48).isActive = true
        usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //MARK:- Button
        view.addSubview(CallToActionButton)
        CallToActionButton.addTarget(self, action: #selector(gotoFollowerController), for: .touchUpInside)
        CallToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        CallToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        CallToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        CallToActionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

extension SearchController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        gotoFollowerController()
        return true
    }
    
}
