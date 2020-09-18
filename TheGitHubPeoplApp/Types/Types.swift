//
//  Types.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 16/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

struct ControllerItem: Error {
    static let GHLogo = "gh-logo"
    static let GHButtonText = "Get Followers"
    static let GHOKText = "OK"
    static let GHAlertMessageWrong = "something went wrong"
    static let GHAlertUnableTo = "unable to complete request"
    static let GHAlertIsEmpty = "Empty Username"
    static let GHAlertMessageNoUsername = "Please enter a username. We need to know who to look for 😄 "
}

struct NetworkItem: Error {
    static let RPNetworkErrorUserMessage = "This username is an invalid request. Please try again"
    static let RPNetworkErrorConnectionMessage = "Unable to make this network request, please try again"
    static let RPNetworkErrorServerMessage = "Unable to connect to server on this network request, please try again"
    static let RPNetworkErrorData = "The data recieved from the server was invalid. Please try again"
}

