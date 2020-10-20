//
//  PokemonListVC.swift
//  PokedexV3
//
//  Created by Salman Faris on 19/10/2020.
//

import UIKit

class PokemonListVC: UIViewController {
    
    var tableView = UITableView()
    var pokemons: [Pokemon] = []
    
    struct Cells {
        static let pokemonCell = "PokemonCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayoutUI()
        configureTableView()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPokemonResult()
    }
    

    func fetchPokemonResult() {
        for i in 1...151 {
            NetworkManager.shared.fetchSinglePokemon(forID: i) { (pokemon) in
                
                self.pokemons.append(pokemon)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    func configureLayoutUI() {
        title = "Pòkedex"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 80
        tableView.register(PokemonCell.self, forCellReuseIdentifier: Cells.pokemonCell)
        tableView.pin(to: view)
    }
    
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}


extension PokemonListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.pokemonCell) as! PokemonCell
        let pokemon = pokemons[indexPath.row]
        cell.set(pokemon: pokemon)
        
        return cell
    }
}
