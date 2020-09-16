//
//  MainTabBarController.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 16/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit
//step 3 - create main tab bar controller

class MainTabBarController: UITabBarController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //step 4 - a test background color, dont forget to switch over to main tab bar controller in SceneDelegate
        //view.backgroundColor = .yellow
        //setupNavBarControllerCustom()
        setupTC()
        
    }
    //step 4 create private func to create our tabs, passing in the systemitem and tag
    private func setupNC(with rootViewController: UIViewController, title: String,tabBarSystemItem: UITabBarItem.SystemItem, tag: Int) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.title = title
        navigationController?.tabBarItem.title = title
        navigationController?.tabBarItem.tag = tag
        navController.tabBarItem = UITabBarItem(tabBarSystemItem: tabBarSystemItem, tag: tag)
        return navController
    }
    //step 5 create another function to do the creation
    private func setupTC() {
        viewControllers = [
            setupNC(with: SearchController(), title: "Search", tabBarSystemItem: .search, tag: 0),
            setupNC(with: FavouritesController(), title: "Favourties", tabBarSystemItem: .favorites, tag: 1),
            ]
        
        tabBar.tintColor = .systemGreen
        
    }
    //step 6 - optional for large titles if decide to use later on
    private func setupNavBarControllerCustom() {
        
        UINavigationBar.appearance().prefersLargeTitles = true
        
    }
    
}
