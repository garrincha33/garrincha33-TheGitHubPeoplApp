//
//  RPEmptyStateView.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 21/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

class RPEmptyStateView: UIView {
    
    let messageLable = RPTitleLable(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLable.text = message
        configure()
    }
    
    private func configure() {
        addSubview(messageLable)
        addSubview(logoImageView)
        
        messageLable.numberOfLines = 2
        messageLable.textColor = .secondaryLabel
        
        logoImageView.image = UIImage(named: "empty-state-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLable.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100),
            messageLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100),
            messageLable.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 200),

            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.1),
            logoImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.1),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 250),
            logoImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 70),
        ])
        
        
    }
    
}
