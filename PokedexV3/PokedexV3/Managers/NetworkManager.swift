//
//  NetworkManager.swift
//  PokedexV3
//
//  Created by Salman Faris on 20/10/2020.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://pokeapi.co/api/v2/"
    let pokemonLimit = 151
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    
    func fetchSinglePokemon(forID id: Int, completionHandler: @escaping (Pokemon) -> Void) {
        let endpoint = baseURL + "pokemon/\(id)"
        
        guard let url = URL(string: endpoint) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                print("Error with fetching data.")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Unexpected status code.")
                return
            }
            
            guard let data = data else {
                print("Error handling data.")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completionHandler(pokemon)
            }
            catch {
                print("Error decoding data.")
                return
            }
        }
        
        task.resume()
    }
    
    
    func fetchPokemonResult(completionHandler: @escaping ([PokemonResult]) -> Void) {
        let endpoint = baseURL + "pokemon?limit=\(pokemonLimit)"
        
        guard let url = URL(string: endpoint) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("Error with fetching data: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error with response, unexpected status code: \(response!)")
                return
            }
            
            guard let data = data else {
                print("Error with handling data.")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let pokemonResults = try decoder.decode(PokemonList.self, from: data)
                print("Success fetching data!")
                completionHandler(pokemonResults.results)
            }
            catch {
                print("Error with decoding data.")
                return
            }
        }
        
        task.resume()
    }
    
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
                }
                    
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}
