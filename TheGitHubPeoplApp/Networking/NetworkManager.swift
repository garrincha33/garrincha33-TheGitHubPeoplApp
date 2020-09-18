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

    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], RPError>) -> Void) {
        
        let endPoint = BASEURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.RPNetworkErrorConnectionMessage))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.RPNetworkErrorUserMessage))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.RPNetworkErrorUserMessage))
                return
            }
            
            guard let data = data else {
                completed(.failure(.RPNetworkErrorUserMessage))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
                
            } catch {
                completed(.failure(.RPNetworkErrorUserMessage))
            }
        }
        task.resume()
    }
}
