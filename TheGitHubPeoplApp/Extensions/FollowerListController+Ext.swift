//
//  FollowerListController+Ext.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 26/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

extension FollowerListController: UICollectionViewDelegate {

    // CODE REVIEW: Why not willDisplayCell instead?
    //MARK:- pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if offSetY > contentHeight - screenHeight {
            guard hasMoreFollowers else { return }
            // CODE REVIEW: By making this extension, you are effectively forcing the page to be public
            page += 1
            // CODE REVIEW: Naming convention: makeNetworkCall is ambiguous
            // CODE REVIEW: if I already know the page, why do I have to pass it as a parameter?
            // CODE REVIEW: What would happen if there was an empty username? Why do you want to pass an empty string and call this method with the empty string?
            makeNetworkCall(username: username ?? "", page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = UserInfoController()
        let activeArray = isSearching ? followersFiltered : followers
        let follower = activeArray[indexPath.row]
        controller.username = follower.login
        controller.delegate = self
        let navController = UINavigationController(rootViewController: controller)
        present(navController, animated: true)
    }
}

extension FollowerListController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {return}
        isSearching = true
        followersFiltered = (filter.isEmpty) ? followers : followers.filter ({$0.login?.localizedCaseInsensitiveContains(filter) == true})
        DispatchQueue.main.async { //adding this is in weird warnings
            self.updateData(on: self.followersFiltered)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: followers)
        isSearching = false
    }
}

extension FollowerListController: FollowerListControllerDelegate {
    func didTapGetFollowers(username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        followersFiltered.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        makeNetworkCall(username: username, page: page)
    }
}

