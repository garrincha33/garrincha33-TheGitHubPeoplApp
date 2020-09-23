//
//  RPRepoItemController.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 23/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

class RPRepoItemController: RPInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        
    }
    //step 12 configure needed items
    private func configureItems() {
        itemInfoControllerOne.set(itemInfoType: .repos, with: user.publicRepos)
        itemInfoControllerTwo.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(to: .systemPurple, title: "GitHub Profile")
    }
    
}
