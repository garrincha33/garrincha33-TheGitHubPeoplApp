//
//  ErrorMessages.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 18/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import Foundation

// CODE REVIEW: This is ok, the only thing I'd note here is missing localization.
enum RPError: String, Error {
    case GHLogo = "gh-logo"
    case GHButtonText = "Get Followers"
    case GHOKText = "OK"
    case GHAlertMessageWrong = "something went wrong"
    case GHAlertUnableTo = "unable to complete request"
    case GHAlertIsEmpty = "Empty Username"
    case GHAlertMessageNoUsername = "Please enter a username. We need to know who to look for 😄 "
    case RPNetworkErrorUserMessage = "This username is an invalid request. Please try again"
    case RPNetworkErrorConnectionMessage = "Unable to make this network request, please try again"
    case RPNetworkErrorServerMessage = "Unable to connect to server on this network request, please try again"
    case RPNetworkErrorData = "The data recieved from the server was invalid. Please try again"
    case RPNetworkErrorUnableToFave = "unable to favourite"
    case RPNetworkErrorAlreadyFave = "you have already added this user to favourties"
}
