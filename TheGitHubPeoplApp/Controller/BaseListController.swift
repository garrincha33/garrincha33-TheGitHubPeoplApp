//
//  BaseListController.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 18/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

class BaseListController: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        
         collectionView.backgroundColor = .systemBackground
         
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
