//
//  Users.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 17/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import Foundation

struct User: Codable {
    var login: String?
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String // CODE REVIEW: Naming convention: I usually prefer URL over Url, but that's up to you.
    var following: Int
    var followers: Int // CODE REVIEW: Naming convention: followers -> followersCount?
    var createdAt: String // CODE REVIEW: Why is this a string and not a Date?
}
