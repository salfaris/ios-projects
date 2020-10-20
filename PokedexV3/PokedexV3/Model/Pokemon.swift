//
//  Pokemon.swift
//  PokedexV3
//
//  Created by Salman Faris on 20/10/2020.
//

import Foundation

struct PokemonList: Codable {
    let results: [PokemonResult]
}


struct PokemonResult: Codable {
    let name: String
    let url: String
}
