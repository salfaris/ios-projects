//
//  PokemonImageView.swift
//  PokedexV3
//
//  Created by Salman Faris on 20/10/2020.
//

import UIKit

class PokemonImageView: UIImageView {

    let cache = NetworkManager.shared.cache
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setSprite(to imageIdentifier: UIImage) {
        self.image = imageIdentifier
    }
    
    
    
    func downloadSprite(fromURL url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
}
