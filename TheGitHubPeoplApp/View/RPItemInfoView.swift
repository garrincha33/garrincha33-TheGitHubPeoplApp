//
//  RPItemInfoView.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 22/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit
//step 1 create enum for types
enum ItemInfoType {
    case repos, gists, followers, following
}
//step2 create class for infoView
class RPItemInfoView: UIView {
    //step 3 create items
    let symbolImageView = UIImageView()
    let titleLable = RPTitleLable(textAlignment: .left, fontSize: 14)
    let countLable = RPTitleLable(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //step 4 func to configure
    private func configure() {
        addSubview(symbolImageView)
        addSubview(titleLable)
        addSubview(countLable) //MARK:- Step 15 fixed bug
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLable.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLable.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLable.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLable.heightAnchor.constraint(equalToConstant: 18),
            
            countLable.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLable.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLable.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLable.heightAnchor.constraint(equalToConstant: 18),
        
        ])
    }
    //step 5 set symbols and counts using enum
    func set(itemInfoType: ItemInfoType, with count: Int) {
        switch itemInfoType {
        case .repos:
            symbolImageView.image = UIImage(systemName: SFSymbols.repos)
            titleLable.text = "Public Repos"
        case .gists:
            symbolImageView.image = UIImage(systemName: SFSymbols.gists)
            titleLable.text = "Public Gists"
        case .followers:
            symbolImageView.image = UIImage(systemName: SFSymbols.followers)
            titleLable.text = "Followers"
        case .following:
            symbolImageView.image = UIImage(systemName: SFSymbols.following)
            titleLable.text = "Following"
        }
        
        countLable.text = String(count)
    }
}
