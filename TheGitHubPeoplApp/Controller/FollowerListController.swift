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
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let padding: CGFloat = 16
    
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
    @objc private func addToFaves() {
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username ?? "") { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
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

     func makeNetworkCall(username: String, page: Int) {
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

    // CODE REVIEW: I don't think you use this method...
    private func configure<T: ConfigureCell>(_ cellType: T.Type, with app: Follower, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configure(with: app)
        return cell
    }
    
    private func configureDataSource() {
        // CODE REVIEW: very nice use of UICollectionViewDiffableDataSource!
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomFollowerCell.reuseIdentifier, for: indexPath) as! CustomFollowerCell
            cell.configure(with: follower)
            return cell
        })
    }
    
     func updateData(on followers: [Follower]) {
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

