//
//  UIHelper.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 21/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

// CODE REVIEW: UIHelper is such an ambiguous name. If you need a UICollectionViewFlowLayout factory, follow a Factory pattern.
struct UIHelper {

    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
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
}
