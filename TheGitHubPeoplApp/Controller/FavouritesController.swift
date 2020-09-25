//
//  FavouritesController.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 16/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

class FavouritesController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        PersistanceManager.retrieveFavourites { (result) in
            switch result {
            case.success(let faves):
                print(faves)
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
}

