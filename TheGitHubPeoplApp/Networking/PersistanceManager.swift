//
//  PersistanceManager.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 24/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

enum PersistanceActionType {
    case add, remove
}

// CODE REVIEW: Why is a PersistanceManager an enum? NetworkManager is a singleton class. Let's keep the patterns consistent throughout the cocebase.
enum PersistanceManager {
    enum Keys {
        static let favourties = "favourites"
    }

    static func updateWith(favourite: Follower, actionType: PersistanceActionType, completed: @escaping (RPError?) -> Void) { retrieveFavourites { result in
        switch result {
        case .success(let favourites):
            var retrievedFavourties = favourites
            
            switch actionType {
            case .add:
                guard !retrievedFavourties.contains(favourite) else {
                    completed(.RPNetworkErrorAlreadyFave)
                    return
                }
                retrievedFavourties.append(favourite)
            case .remove:
                retrievedFavourties.removeAll { $0.login == favourite.login }
            }
            
            completed(save(favourites: retrievedFavourties))
            
        case .failure(let error):
            completed(error)
        }
    }
    }
    static private let defaults = UserDefaults.standard

    static func retrieveFavourites(completed: @escaping (Result<[Follower], RPError>) -> Void){
        guard let favouritesData = defaults.object(forKey: Keys.favourties) as? Data else {
            completed(.success([]))
            return
        }

        do {
            let decoder = JSONDecoder()
            let favourties = try decoder.decode([Follower].self, from: favouritesData)
            completed(.success(favourties))
        } catch {
            completed(.failure(.RPNetworkErrorUnableToFave))
        }
    }
    static func save(favourites: [Follower]) -> RPError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavourites = try encoder.encode(favourites)
            defaults.setValue(encodedFavourites, forKey: Keys.favourties)
            return nil
        } catch {
            return .GHAlertUnableTo
        }
    }
}
