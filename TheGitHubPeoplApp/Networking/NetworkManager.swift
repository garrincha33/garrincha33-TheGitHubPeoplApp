//
//  NetworkManager.swift
//  TheGitHubPeoplApp
//
//  Created by Richard Price on 17/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

class NetworkManager {

    static let shared = NetworkManager()
    let imageCache = NSCache<NSString, UIImage>() // CODE REVIEW: why not private?
    private init() {}

    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], RPError>) -> Void) {
        
        let endPoint = BASEURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.RPNetworkErrorConnectionMessage))
            return
        }

        // CODE REVIEW: couldn't you have a single method for handling requests and then only call it with a few parameters?
        // getFollowers and getUserInfo are very similar
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
    func getUserInfo(for username: String, completed: @escaping (Result<User, RPError>) -> Void) {
        let endpoint = BASEURL + "\(username)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.RPNetworkErrorConnectionMessage))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.GHAlertUnableTo))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.RPNetworkErrorConnectionMessage))
                return
            }
            
            guard let data = data else {
                completed(.failure(.GHAlertUnableTo))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch {
                completed(.failure(.GHAlertUnableTo))
            }
        }
        
        task.resume()
    }
    
    
    
    
    //GENERIC CALL
    func makeUrlRequest<T: Any>(for username: String, page: Int?, completed: @escaping (Result<T, RPError>) -> Void) {
        let endpoint = BASEURL + "\(username)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.RPNetworkErrorConnectionMessage))
            return
        }
         let urlTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
             guard error == nil else {
                completed(.failure(.RPNetworkErrorData))
                 return
             }

             guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                 completed(.failure(.RPNetworkErrorServerMessage))
                 return
             }

             guard let data = data else {
                completed(.failure(.RPNetworkErrorData))
                 return
             }

            guard let decodedData: T = self.decodedData(data) as? T else {
                completed(.failure(.RPNetworkErrorData))
                 return
             }

             completed(.success(decodedData))
         }

         urlTask.resume()
     }
    
    private func decodedData(_ data: Data) -> String? {
            return String(data: data, encoding: .utf8)
        }
}
