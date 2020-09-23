//
//  RPInfoViewController.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 23/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit
//step 6 create a view controller to diplsay the info view, this is the superclass
// we will create another 2 controllers based on this class
class RPInfoViewController: UIViewController {

    //step 7 create isntances and button
    let itemInfoControllerOne = RPItemInfoView()
    let itemInfoControllerTwo = RPItemInfoView()
    let actionButton = RPUIButton()
    
    //step 7 - also create a user so we can access the User we need and custom init
    var user: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        setupUI()
    }
    //step 8 create config back func
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }

    //step 9 create a stack view creator func
    private func stackViewCreator(with stack: UIStackView) -> UIStackView {
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    //step 10 step ui
    private func setupUI() {
        let stack = UIStackView(arrangedSubviews: [itemInfoControllerOne, itemInfoControllerTwo])
        let stackView = stackViewCreator(with: stack)
        
        view.addSubview(stackView)
        view.addSubview(actionButton)

        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44),
        ])
        
    }
    
}
