//
//  Follower.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 18/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import Foundation

struct Follower: Codable, Hashable {
    // CODE REVIEW: What's the purpose of a Follower with no login and no avatarUrl?
    var login: String?
    var avatarUrl: String?
}
