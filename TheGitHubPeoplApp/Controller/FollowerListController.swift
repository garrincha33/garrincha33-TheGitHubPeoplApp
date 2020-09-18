//
//  FollowerListController.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 17/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

class FollowerListController: UIViewController {
    
    //step 1 add section for diff data source
    enum Section {
        case main
    }

    var collectionView: UICollectionView!
    var username: String?
    //step 2 create data source, your model from api needs to conform to hashable
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    //step 7 add array to append
    var followers: [Follower] = []
    
    
    fileprivate let padding: CGFloat = 16

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        makeNetworkCall()
        configureCollectionViewController()
        //step 9 call your data source
        configureDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func configureCollectionViewController() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink
        collectionView.register(CustomFollowerCell.self, forCellWithReuseIdentifier: CustomFollowerCell.reuseIdentifier)
    }

    private func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width =  view.bounds.width
        let padding: CGFloat = 12
        let minItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minItemSpacing * 2)
        let itemWidth = availableWidth / 3
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
        
        
    }

    private func makeNetworkCall() {
        NetworkManager.shared.getFollowers(for: username ?? RPError.RPNetworkErrorUserMessage.rawValue, page: 1) { result in
            switch result {
            case .success(let followers):
                print(followers)
                //step 8 append onto the array and call update data
                self.followers = followers
                self.updateData()
            case .failure(let error):
                self.presentRPAlertOnMainThread(title: RPError.GHAlertMessageWrong.rawValue, message: error.rawValue, buttonTitle: RPError.GHOKText.rawValue)
            }
        }
    }
    
    //step 4 add configure method for cell
    func configure<T: ConfigureCell>(_ cellType: T.Type, with app: Follower, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configure(with: app)
        return cell
    }
    
    //step 5 config data source
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomFollowerCell.reuseIdentifier, for: indexPath) as! CustomFollowerCell
            cell.configure(with: follower)
            return cell
        })
    }
    //step 6 add update data to render snapshot
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}
