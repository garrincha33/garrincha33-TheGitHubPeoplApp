//
//  ConfigureCell.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 18/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import Foundation

// CODE REVIEW: Naming convention: protocol naming - ConfigureCell -> ConfigurableCell
// In English, to configure something = verb, configurable = adjective
protocol ConfigureCell {

    // CODE REVIEW: styling: spaces around get, do you use SwiftLint? It's a good idea to put it into your sample to impress the code reviewers that you take extra care.
    static var reuseIdentifier: String { get }

    // CODE REVIEW: Naming conventions. Ok, so this ConfigureCell protocol is used for configuring with follower?
    // I'd say rename the protocol or do something like
    func configure(with followers: Follower)
    
}

protocol Configurable {
    associatedtype Entity
    func configure(with entity: Entity)
}

class MyFollowerConfigurableClass: Configurable {
    typealias Entity = Follower

    func configure(with entity: Follower) {
        // Like this
    }
}
