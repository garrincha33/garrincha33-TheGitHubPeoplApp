//
//  Follower.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 18/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import Foundation
//step 4 renamed to follower
struct Follower: Codable, Hashable {
    var login: String?
    var avatarUrl: String?
}
