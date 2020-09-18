//
//  FollowerListController.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 17/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

class FollowerListController: UIViewController {
    
    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        //step 6 - make the call
        makeNetworkCall()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    //step 5 create network call function
    private func makeNetworkCall() {
        NetworkManager.shared.getFollowers(for: username ?? "No Username", page: 1) { (followers, error) in
            guard let followers = followers else {
                self.presentRPAlertOnMainThread(title: "Hmmm theres a problem", message: error ?? NetworkItem.RPNetworkErrorUserMessage, buttonTitle: ControllerItem.GHOKText)
                return
            }
            print("followers count \(followers.count)")
            print(followers)
        }
    }
}
