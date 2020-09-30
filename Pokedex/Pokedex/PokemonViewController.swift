import UIKit

class PokemonViewController: UIViewController {
    var url: String!
    var pokemonID: Int!
    var caughtPokemons = [Int: Bool]()
    let defaults = UserDefaults.standard
    
    struct Keys {
        static let pokemonIsCaught = "pokemonIsCaught"
    }
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var type1Label: UILabel!
    @IBOutlet var type2Label: UILabel!
    @IBOutlet var catchButton: UIButton!

    func capitalize(text: String) -> String {
        return text.prefix(1).uppercased() + text.dropFirst()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        nameLabel.text = ""
        numberLabel.text = ""
        type1Label.text = ""
        type2Label.text = ""
        
        loadPokemon()
    }

    func loadPokemon() {
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            guard let data = data else {
                return
            }

            do {
                let result = try JSONDecoder().decode(PokemonResult.self, from: data)
                DispatchQueue.main.async {
                    // Allow usage of pokemon ID for elsewhere within this file
                    self.pokemonID = result.id
                    
                    self.navigationItem.title = self.capitalize(text: result.name)
                    self.nameLabel.text = self.capitalize(text: result.name)
                    self.numberLabel.text = String(format: "#%03d", result.id)

                    for typeEntry in result.types {
                        if typeEntry.slot == 1 {
                            self.type1Label.text = typeEntry.type.name
                        }
                        else if typeEntry.slot == 2 {
                            self.type2Label.text = typeEntry.type.name
                        }
                    }
                    
                    
                }
            }
            catch let error {
                print(error)
            }
        }.resume()
    }
    
    // Method is called when catch button is clicked
    @IBAction func toggleCatch() {
        if caughtPokemons[pokemonID] != nil {
            // Remove the id (button was showing Release)
            caughtPokemons[pokemonID] = nil
            saveCatchState(saveState: false)
            catchButton.setTitle("Catch", for: .normal)
        }
        else {
            // Add the id (button was showing Catch)
            caughtPokemons[pokemonID] = true
            saveCatchState(saveState: true)
            catchButton.setTitle("Release", for: .normal)
        }
    }
    
    func saveCatchState(saveState: Bool) {
        defaults.set(saveState, forKey: Keys.pokemonIsCaught)
    }
}
