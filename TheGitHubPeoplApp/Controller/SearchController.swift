//
//  SearchController.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 16/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit


class SearchController: UIViewController {
    
    //step 1 - create logo textF and Button, empty closure constructed
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ControllerItem.GHLogo)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    //custom styling already created, incaser of reuse
    let usernameTextField = RPUITextfield()
    let CallToActionButton = RPUIButton(backgroundColor: .systemGreen, title: ControllerItem.GHButtonText)
    
    let button: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.tintColor = UIColor.systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupUI()
        
    }
    
    //step 2 hide nav in will did appear, view did load only called once on load
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    //step 3 setupUI function for items call in view did load
    
    func setupUI() {
        //MARK:- Logo
        view.addSubview(logoImageView)
        logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        //MARK:- TextField
        view.addSubview(usernameTextField)
        usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48).isActive = true
        usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //MARK:- Button
        view.addSubview(CallToActionButton)
        CallToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        CallToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        CallToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        CallToActionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
