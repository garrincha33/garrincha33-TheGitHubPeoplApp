//
//  MainTabBarController.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 16/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit


class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTC()
        
    }

    private func setupNC(with rootViewController: UIViewController, title: String,tabBarSystemItem: UITabBarItem.SystemItem, tag: Int) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.title = title
        navigationController?.tabBarItem.title = title
        navigationController?.tabBarItem.tag = tag
        navController.tabBarItem = UITabBarItem(tabBarSystemItem: tabBarSystemItem, tag: tag)
        return navController
    }

    private func setupTC() {
        viewControllers = [
            setupNC(with: SearchController(), title: "Search", tabBarSystemItem: .search, tag: 0),
            setupNC(with: FavouritesController(), title: "Favourties", tabBarSystemItem: .favorites, tag: 1),
            ]
        
        tabBar.tintColor = .systemGreen
        
    }

    private func setupNavBarControllerCustom() {
        
        UINavigationBar.appearance().prefersLargeTitles = true
        
    }
    
}
