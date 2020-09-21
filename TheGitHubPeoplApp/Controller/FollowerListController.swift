//
//  FollowerListController.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 17/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

class FollowerListController: UIViewController {

    enum Section {
        case main
    }

    var collectionView: UICollectionView!
    var username: String?
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var followers: [Follower] = []
    //MARK:- pagination
    //step 4 add page and bool, keep track of page number and check if anymore pages to load
    var page: Int = 1
    var hasMoreFollowers = true
    
    fileprivate let padding: CGFloat = 16

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        makeNetworkCall(username: username ?? "", page: page)
        configureCollectionViewController()
        configureDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func configureCollectionViewController() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        //step 2 set delegate
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CustomFollowerCell.self, forCellWithReuseIdentifier: CustomFollowerCell.reuseIdentifier)
    }

    //step 3 amend network call to take in a follower and page number
    private func makeNetworkCall(username: String, page: Int) {
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let followers):
                //step 6 append your followers if less than 100
                if followers.count < 100 {self.hasMoreFollowers = false}
                self.followers.append(contentsOf: followers)
                self.updateData()
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

    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}

//step 1 - create an extension to access the scrollEndDragging and set offsets
extension FollowerListController: UICollectionViewDelegate {
    //MARK:- pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        
        if offSetY > contentHeight - screenHeight {
            //step 5 make call for username and page
            guard hasMoreFollowers else {return}
            page += 1
            makeNetworkCall(username: username ?? "", page: page)
        }
    }
}
