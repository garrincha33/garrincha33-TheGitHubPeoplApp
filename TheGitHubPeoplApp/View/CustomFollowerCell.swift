//
//  CustomFollowerCell.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 18/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

class CustomFollowerCell: UICollectionViewCell {
    
    static let reuseIdentifier = "followers"
    
//    func configure(with followers: Followers) {
//        usernameLable.text = followers.login
//    }
//
    var followerItems: Followers! {
        didSet {
            
            usernameLable.text = followerItems.login
            
        }
    }

    let avatarImageView = RPImageView(frame: .zero)
    let usernameLable = RPTitleLable(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
        
    }
    
    private func configure() {
        let padding: CGFloat = 8
        addSubview(avatarImageView)
        avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
        avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding).isActive = true
        avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor).isActive = true
        
        addSubview(usernameLable)
        usernameLable.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12).isActive = true
        usernameLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        usernameLable.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        usernameLable.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
