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
    var filteredPokemons: [Pokemon] = []
    var isSearching = false
    
    struct Cells {
        static let pokemonCell = "PokemonCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemonResult()
        configureSearchController()
        configureLayoutUI()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        title = "Wild Pòkedex"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a Pòkemon"
        navigationItem.searchController = searchController
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
        if isSearching {
            return filteredPokemons.count
        }
        else {
            return pokemons.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.pokemonCell) as! PokemonCell
        
        let pokemon = isSearching ? filteredPokemons[indexPath.row] : pokemons[indexPath.row]
        cell.set(pokemon: pokemon)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = isSearching ? filteredPokemons[indexPath.row] : pokemons[indexPath.row]
        let destVC = PokemonDisplayVC(pokemon: pokemon)
        
        navigationController?.pushViewController(destVC, animated: true)
    }
}


extension PokemonListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredPokemons = pokemons.filter { $0.name.lowercased().contains(filter.lowercased()) }
        
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        
        tableView.reloadData()
    }
}
