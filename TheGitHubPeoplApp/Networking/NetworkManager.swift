//
//  NetworkManager.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 17/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import Foundation

class NetworkManager {

    static let shared = NetworkManager()
    private init() {}
    //step 2 replace with result and pass in new enum
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Followers], RPError>) -> Void) {
        
        let endPoint = BASEURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            //step 3 update completed statemenet
            completed(.failure(.RPNetworkErrorConnectionMessage))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                //step 4 update completed statemenet
                completed(.failure(.RPNetworkErrorUserMessage))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                //step 5 update completed statemenet
                completed(.failure(.RPNetworkErrorUserMessage))
                return
            }
            
            guard let data = data else {
                //step 6 update completed statemenet
                completed(.failure(.RPNetworkErrorUserMessage))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Followers].self, from: data)
                //step 7 added success
                completed(.success(followers))
                
            } catch {
                 //step 8 add failure
                completed(.failure(.RPNetworkErrorUserMessage))
            }
        }
        task.resume()
    }
}
