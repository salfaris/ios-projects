//
//  PokemonInfoVC.swift
//  PokedexV3
//
//  Created by Salman Faris on 19/10/2020.
//

import UIKit

class PokemonInfoVC: UIViewController {
    
    let pokemonLabel = UILabel()
    let pokemonID = UILabel()
    let pokemonCatchButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUILayout()
        configurePokemonLabel()
        configurePokemonID()
        configurePokemonCatchButton()
    }

    
    func configureUILayout() {
        view = UIView()
        view.backgroundColor = .systemBackground
    }
    
    func configurePokemonLabel() {
        view.addSubview(pokemonLabel)
        pokemonLabel.text = "Bulbasaur"
        pokemonLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pokemonLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pokemonLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    func configurePokemonID() {
        pokemonID.text = "001"
        pokemonID.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pokemonID)
        
        NSLayoutConstraint.activate([
            pokemonID.centerYAnchor.constraint(equalTo: pokemonLabel.centerYAnchor, constant: 50),
            pokemonID.centerXAnchor.constraint(equalTo: pokemonLabel.centerXAnchor)
        ])
    }
    
    
    func configurePokemonCatchButton() {
        // pokemonCatchButton.backgroundColor = .systemGreen
        pokemonCatchButton.setTitleColor(.systemRed, for: .normal)
        pokemonCatchButton.setTitle("Catch", for: .normal)
        pokemonCatchButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pokemonCatchButton)
        
        NSLayoutConstraint.activate([
            pokemonCatchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            pokemonCatchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            pokemonCatchButton.topAnchor.constraint(equalTo: pokemonID.bottomAnchor, constant: 50),
            pokemonCatchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
