//
//  RPAlertController.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 17/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit
//step 7 create the alert controller

class RPAlertController: UIViewController {
    
    //step 8 create and empty container view and intialize lables and button
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()

    let titleLable = RPTitleLable(textAlignment: .center, fontSize: 20)
    let errorMessageLable = RPBodyLable(textAlignment: .center)
    let actionButton = RPUIButton(backgroundColor: .systemPink, title: ControllerItem.GHOKText)
    //MARK:- ALERT
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    let padding: CGFloat = 20
    
    //step 9 custom init
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    //step 11 - setup dismiss func
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         //step 10 set background
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        //step 11 
        setupUI()
        
        
    }
    //step 11 create setup function and call
    private func setupUI() {
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        containerView.widthAnchor.constraint(equalToConstant: 280),
        containerView.heightAnchor.constraint(equalToConstant: 280)
        ])
        
        containerView.addSubview(titleLable)
        titleLable.text = alertTitle ?? ControllerItem.GHAlertMessage
        titleLable.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding).isActive = true
        titleLable.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding).isActive = true
        titleLable.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding).isActive = true
        titleLable.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? ControllerItem.GHOKText, for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding).isActive = true
        actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding).isActive = true
        actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        containerView.addSubview(errorMessageLable)
        errorMessageLable.text = message ?? ControllerItem.GHAlertUnableTo
        errorMessageLable.numberOfLines = 4
        errorMessageLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 8).isActive = true
        errorMessageLable.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding).isActive = true
        errorMessageLable.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding).isActive = true
        errorMessageLable.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12).isActive = true
    }
}
