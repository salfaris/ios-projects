//
//  PokemonCell.swift
//  PokedexV3
//
//  Created by Salman Faris on 20/10/2020.
//

import UIKit

class PokemonCell: UITableViewCell {
    
    var pokemonImageView = PokemonImageView(frame: .zero)
    var pokemonLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(pokemonImageView)
        addSubview(pokemonLabel)
        accessoryType = .disclosureIndicator
        configureImageView()
        configureLabel()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(pokemon: Pokemon) {
        pokemonLabel.text = pokemon.name.capitalized
        pokemonImageView.downloadSprite(fromURL: pokemon.sprites.frontDefault)
        // pokemonImageView.setSprite(to: Images.charmander)
    }
    
    
    func configureImageView() {
        pokemonImageView.layer.cornerRadius = 10
        pokemonImageView.clipsToBounds = true  // Show the corner radius
        setImageConstraints()
    }
    
    
    func configureLabel() {
        pokemonLabel.numberOfLines = 0
        pokemonLabel.adjustsFontSizeToFitWidth = true  // Shrink if font size is too big
        setLabelConstraints()
    }
    
    
    func setImageConstraints() {
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pokemonImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            pokemonImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 80),
            pokemonImageView.widthAnchor.constraint(equalTo: pokemonImageView.heightAnchor)
        ])
    }
    
    
    func setLabelConstraints() {
        pokemonLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pokemonLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            pokemonLabel.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: 15),
            pokemonLabel.heightAnchor.constraint(equalToConstant: 80),
            pokemonLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
}
