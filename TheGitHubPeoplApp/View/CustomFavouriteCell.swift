//
//  CustomFavouriteCell.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 25/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

//step 1 create a custom cell

class CustomFavouriteCell: UITableViewCell, ConfigureCell {
    static var reuseIdentifier: String = "FavouriteCell"
    //use protocol for configuring cell
    func configure(with followers: Follower) {
        usernameLable.text = followers.login
        avatarImage.downloadImage(from: followers.avatarUrl ?? "no avatar")
    }
    
    let avatarImage = RPImageView(frame: .zero)
    let usernameLable = RPTitleLable(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //step 3 standard config function for constrinats
    private func configure() {
        addSubview(avatarImage)
        addSubview(usernameLable)
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
//        avatarImage.translatesAutoresizingMaskIntoConstraints = false
//        usernameLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImage.heightAnchor.constraint(equalToConstant: 60),
            avatarImage.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLable.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLable.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 24),
            usernameLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLable.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
