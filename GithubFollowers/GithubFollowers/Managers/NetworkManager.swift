//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Salman Faris on 09/10/2020.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    let perPageFollowers = 100
    let cache = NSCache<NSString, UIImage>()
    
    // Singleton: Ensures there is only one instance of it (we make it private)
    private init() {}
    
    
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint = baseURL + "\(username)/followers?per_page=\(perPageFollowers)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // data, response, task are all optionals!
            
            // It does not even work.
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            // Check if this response is not nil and status code is 200 (OK).
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            // Check if data is not nil.
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            // Finally. Decode the received JSON object.
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)  // Decode data into an array of Follower
                completed(.success(followers))
            }
            catch {
                // For developers to check: completed(nil, error.localizedDescription)
                completed(.failure(.invalidData))
            }
            
        }
        
        // Starts the network call
        task.resume()
    }

}
