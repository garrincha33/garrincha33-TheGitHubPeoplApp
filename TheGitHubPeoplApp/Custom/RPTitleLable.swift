//
//  RPTitleLable.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 17/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

// CODE REVIEW: typo -  RPTitleLable -> RPTitleLabel
// CODE REVIEW: Similar to favourite vs favorite. Unfortunately for the British, the USA is now a dominant power in the world, so in many areas including iOS development, the American English is the technical standard.
class RPTitleLable: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }

    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
