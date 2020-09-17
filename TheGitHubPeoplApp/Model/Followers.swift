//
//  Followers.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 17/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import Foundation

//step 2 created followers struct - these need to exactly match your json network call
struct Followers: Codable {
    var login: String
    var avatarUrl: String
}
