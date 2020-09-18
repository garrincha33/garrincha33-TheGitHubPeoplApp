//
//  NetworkManager.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 17/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import Foundation

//step 2 create your network manager

class NetworkManager {
    //step 3 create singleton instance
    static let shared = NetworkManager()
    private init() {}
    
    //step 4 network call function
    func getFollowers(for username: String, page: Int, completed: @escaping ([Followers]?, String?) -> Void) {
        
        let endPoint = BASEURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completed(nil, NetworkItem.RPNetworkErrorConnectionMessage)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(nil, NetworkItem.RPNetworkErrorUserMessage)
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, NetworkItem.RPNetworkErrorServerMessage)
                return
            }
            
            guard let data = data else {
                completed(nil, NetworkItem.RPNetworkErrorData )
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Followers].self, from: data)
                completed(followers, nil)
                
            } catch {
                completed(nil, NetworkItem.RPNetworkErrorUserMessage)
            }
        }
        task.resume()
    }
}
