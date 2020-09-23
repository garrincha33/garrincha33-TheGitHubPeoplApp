//
//  RPFollowerItemController.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 23/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit
//step 13 create your second controller
class RPFollowerItemController: RPInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        
    }

    private func configureItems() {
        itemInfoControllerOne.set(itemInfoType: .repos, with: user.followers)
        itemInfoControllerTwo.set(itemInfoType: .gists, with: user.following)
        actionButton.set(to: .systemGreen, title: "Get Followers")
    }
    
}
