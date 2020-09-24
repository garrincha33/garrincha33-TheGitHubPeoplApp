//
//  RPFollowerItemController.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 23/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

class RPFollowerItemController: RPInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        
    }

    private func configureItems() {
        itemInfoControllerOne.set(itemInfoType: .followers, with: user.followers)
        itemInfoControllerTwo.set(itemInfoType: .following, with: user.following)
        actionButton.set(to: .systemGreen, title: "Get Followers")
    }
    //step 15 override the actionbuitton tap to call get followers
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(user: user)
    }
    
}
