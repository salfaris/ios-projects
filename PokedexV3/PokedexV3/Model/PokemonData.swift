//
//  PokemonData.swift
//  PokedexV3
//
//  Created by Salman Faris on 20/10/2020.
//

import UIKit

typealias pngUrl = String

struct Pokemon: Codable {
    let name: String
    let id: Int
    let sprites: PokemonSprite
    let weight: Int
}


struct PokemonSprite: Codable {
    let frontDefault: pngUrl
}
