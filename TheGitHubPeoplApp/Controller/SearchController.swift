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
    //step 10 - text validation
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
    //step 1 create function for dismisisng keyboard using endEditing adn call in View did load
    private func dismissKeyboardTap() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    //step 7 create objc called when we tap go button
    @objc private func gotoFollowerController() {
        //step 10 - text validation, implement check for no username entered
        guard isUsernameEntered else {
            print("working")
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
        //step 3 - set the delegate
        usernameTextField.delegate = self
        usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48).isActive = true
        usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //MARK:- Button
        view.addSubview(CallToActionButton)
        //step 8 using gotofollwoers controller function for add target
        CallToActionButton.addTarget(self, action: #selector(gotoFollowerController), for: .touchUpInside)
        
        CallToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        CallToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        CallToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        CallToActionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
//step 4 - create extension and UItextDelegate to access should return on press
extension SearchController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //step 6, test with print if needed, but call your gotoFollower func here
        gotoFollowerController()
        return true
    }
    
}
