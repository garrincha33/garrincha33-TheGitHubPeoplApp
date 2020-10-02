//
//  FavouritesController+Ext.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 26/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

extension FavouritesController: UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomFavouriteCell.reuseIdentifier) as! CustomFavouriteCell
        let favorite = favorites[indexPath.row]
        cell.configure(with: favorite)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = UserInfoController()
        let fave    = favorites[indexPath.row]
        controller.username = fave.login
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
    //MARK:-swipe to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        PersistanceManager.updateWith(favourite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else { return }
            self.presentRPAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}


