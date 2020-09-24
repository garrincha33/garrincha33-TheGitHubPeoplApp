//
//  PersistanceManager.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 24/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit
//step 7 create anum to see wether adding or removing
enum PersistanceActionType {
    case add, remove
}

//step 2 create as enum (as not initizlation needed, with a struct initiziler you have for free
enum PersistanceManager {
    enum Keys {
        static let favourties = "favourites"
    }
    
    //step 8 function to updateWith
    static func updateWith(favourite: Follower, actionType: PersistanceActionType, completed: @escaping (RPError) -> Void) { retrieveFavourites { result in
        switch result {
        case .success(let favourites):
            var retrievedFavourties = favourites //step 9 create a temp array to store results
            
            switch actionType {
            case .add:
                guard !retrievedFavourties.contains(favourite) else {
                    completed(.RPNetworkErrorAlreadyFave)
                    return
                }
                //step 10 once retrieved append your temp array
                retrievedFavourties.append(favourite)
            case .remove:
                retrievedFavourties.removeAll { $0.login == favourite.login }
            }
            
            completed(save(favourites: retrievedFavourties) ?? RPError.GHAlertIsEmpty)
            
        case .failure(let error):
            completed(error)
        }
    }
    }
    
    
    //step 3
    static private let defaults = UserDefaults.standard
    //step 4 create a static func to retrieve favies
    static func retrieveFavourites(completed: @escaping (Result<[Follower], RPError>) -> Void){
        guard let favouritesData = defaults.object(forKey: Keys.favourties) as? Data else {
            completed(.success([]))
            return
        }
        //step 5 decode the follower
        do {
            let decoder = JSONDecoder()
            let favourties = try decoder.decode([Follower].self, from: favouritesData)
            completed(.success(favourties))
        } catch {
            completed(.failure(.RPNetworkErrorUnableToFave))
        }
    }
    //step 6 save to userdefaults using enocder
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
