//
//  FavouritesController.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 16/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

class FavouritesController: UIViewController {
    //step 2 create an empty followers array and table view
    let tableView = UITableView()
    var favorites: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    //step 1 config for the view controller
    func configureViewController() {
        view.backgroundColor    = .systemBackground
        title                   = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //step 3 create table view setup
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame         = view.bounds
        tableView.rowHeight     = 80
        tableView.delegate      = self
        tableView.dataSource    = self
        
        tableView.register(CustomFavouriteCell.self, forCellReuseIdentifier: CustomFavouriteCell.reuseIdentifier)
    }
    
    //step 5 amend get faves
    func getFavorites() {
        PersistanceManager.retrieveFavourites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                //step 6 check for empty faves and display error
                if favorites.isEmpty {
                    self.showEmptyStateView(message: "No Favorites?\nAdd one on the follower screen.", in: self.view)
                } else  {
                    //step 7 add to the faves array reload data and bring to front
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
            case .failure(let error):
                self.presentRPAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
}

//step 4 setup your delegate functions //MARK:-Tableview delgates
extension FavouritesController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomFavouriteCell.reuseIdentifier) as! CustomFavouriteCell
        let favorite = favorites[indexPath.row]
        cell.configure(with: favorite)
        return cell
    }
    
    //step 8 when tapping cell goto that followers list
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite    = favorites[indexPath.row]
        let destVC      = FollowerListController()
        destVC.username = favorite.login
        destVC.title    = favorite.login
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    //MARK:-swipe to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //step 9 set editing style
        guard editingStyle == .delete else { return }
        //step 10 get the fave at the index and remove
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        //step 11 remove from persistance
        PersistanceManager.updateWith(favourite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else { return }
            self.presentRPAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}
