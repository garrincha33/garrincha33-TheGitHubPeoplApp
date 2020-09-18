//
//  ConfigureCell.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 18/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import Foundation

protocol ConfigureCell {
    
    static var reuseIdentifier: String {get}
    
    func configure(with followers: Follower)
    
}
