//
//  RPBodyLable.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 17/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

//step 4 create a body lable class

class RPBodyLable: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
     //step 6 - create custom init and call configure function
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    
    //step 5 create custom func
    private func configure() {
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
