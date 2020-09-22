//
//  UserInfoController.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 22/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

//step 1 create a userinfo controller
class UserInfoController: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        print(username ?? "")
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
}
