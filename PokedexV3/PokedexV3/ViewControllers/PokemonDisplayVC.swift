//
//  PokemonDisplayVC.swift
//  PokedexV3
//
//  Created by Salman Faris on 20/10/2020.
//

import UIKit

class PokemonDisplayVC: UIViewController {
    
    let stackView = UIStackView()
    var pokemonImageView = PokemonImageView(frame: .zero)
    var pokemonLabel = UILabel()
    var pokemonID = UILabel()
    var pokemonWeight = UILabel()
    
    var pokemon: Pokemon!
    
    init(pokemon: Pokemon) {
        super.init(nibName: nil, bundle: nil)
        self.pokemon = pokemon
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
        configureBackgroundView()
        layoutUI()
        configureStackView()
    }
    
    func configureUIElements() {
        title = pokemon.name.capitalized
        pokemonLabel.text = pokemon.name.capitalized
        pokemonLabel.adjustsFontSizeToFitWidth = true
        
        pokemonImageView.downloadSprite(fromURL: pokemon.sprites.frontDefault)
        
        pokemonID.text = String(format: "#%03d", pokemon.id)
        
        pokemonWeight.text = "\(pokemon.weight) grams"
    }
     
    func configureBackgroundView() {
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 18
    }
    
    func configureStackView() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        
        stackView.addArrangedSubview(pokemonImageView)
        stackView.addArrangedSubview(pokemonLabel)
        stackView.addArrangedSubview(pokemonID)
        stackView.addArrangedSubview(pokemonWeight)
    }
    
    func layoutUI() {
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // stackView.heightAnchor.constraint(equalToConstant: 200),
            // stackView.widthAnchor.constraint(equalTo: stackView.heightAnchor)
        ])
    }
}
