//
//  FollowerListController.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 17/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

protocol FollowerListControllerDelegate: class {
    func didTapGetFollowers(username: String)
}

class FollowerListController: UIViewController {
    
    enum Section {
        case main
    }
    
    var collectionView: UICollectionView!
    var username: String?
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var followers: [Follower] = []
    var followersFiltered: [Follower] = []
    var isSearching = false
    //MARK:- pagination
    var page: Int = 1
    var hasMoreFollowers = true
    
    fileprivate let padding: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionViewController()
        configureSearchController()
        configureDataSource()
        makeNetworkCall(username: username ?? "", page: page)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureCollectionViewController() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CustomFollowerCell.self, forCellWithReuseIdentifier: CustomFollowerCell.reuseIdentifier)
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFaves))
        navigationItem.rightBarButtonItem = addButton
    }
    //step 1 create add to faves using persistance method
    @objc private func addToFaves() {
        showLoadingView()
        //step 2 netowrk call
        NetworkManager.shared.getUserInfo(for: username ?? "") { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            //step 3 switch on result
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                //step 4 use persistance
                PersistanceManager.updateWith(favourite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    guard let error = error else {
                        self.presentRPAlertOnMainThread(title: "Success!", message: "You have successfully favorited this user 🎉", buttonTitle: "Hooray!")
                        return
                    }
                    self.presentRPAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
            case .failure(let error):
                self.presentRPAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    
    private func makeNetworkCall(username: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.dismissLoadingView()
            }
            switch result {
            case .success(let followers):
                if followers.count < 100 {self.hasMoreFollowers = false}
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty {
                    let message = "This user doesnt have any followers as yet 😀"
                    DispatchQueue.main.sync {
                        self.showEmptyStateView(message: message, in: self.view)
                        return
                    }
                }
                
                self.updateData(on: self.followers)
            case .failure(let error):
                self.presentRPAlertOnMainThread(title: RPError.GHAlertMessageWrong.rawValue, message: error.rawValue, buttonTitle: RPError.GHOKText.rawValue)
            }
        }
    }
    
    func configure<T: ConfigureCell>(_ cellType: T.Type, with app: Follower, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configure(with: app)
        return cell
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomFollowerCell.reuseIdentifier, for: indexPath) as! CustomFollowerCell
            cell.configure(with: follower)
            return cell
        })
    }
    
    private func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        }
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
}

extension FollowerListController: UICollectionViewDelegate {
    //MARK:- pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if offSetY > contentHeight - screenHeight {
            guard hasMoreFollowers else {return}
            page += 1
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
