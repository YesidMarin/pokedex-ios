//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Yesid Marin on 17/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import UIKit
import Toast

class PokemonDetailViewController: UIViewController {
    
    // Table propierties
    private var cellViewModels: [PokemonDetailViewCell] = [PokemonDetailViewCell]()
    
    @IBOutlet weak var viewOpacity: UIView!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonTitle: UILabel!
    @IBOutlet weak var slotOne: UIImageView!
    @IBOutlet weak var slotTwo: UIImageView!
    @IBOutlet weak var pokemonDescription: UILabel!
    @IBOutlet weak var pokemonHeightTitle: UILabel!
    @IBOutlet weak var pokemonHeight: UILabel!
    @IBOutlet weak var pokemonWeightTitle: UILabel!
    @IBOutlet weak var pokemonWeight: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    var presenter: PokemonDetailPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        presenter?.viewDidLoad()
        
        tableView.register(UINib(nibName: "PokemonDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "pokemonDetailViewCell")
    }
}

struct PokemonDetailViewCell {
    let statName: String
    let baseStat: String
    let color: slotColor?
}

extension PokemonDetailViewController: PokemonDetailViewProtocol {
    
    func showPokemon(_ pokemon: PokemonBodyDto) {
        
        var color: slotColor?
        var slotOne = "None"
        var slotTwo = "None"
        
        pokemon.description.forEach { (description) in
            if description.slot == 1 {
                color = slotColor(rawValue: description.nameSlot)!
                slotOne = description.nameSlot.capitalized
            } else if description.slot == 2 {
                slotTwo = description.nameSlot.capitalized
            }
        }
        
        viewOpacity.changeBackgroundColor(color!)
        pokemonHeightTitle.changeTextColor(color!)
        pokemonWeightTitle.changeTextColor(color!)
        imageView(path: pokemon.id)
        self.slotOne.image = UIImage(named: "\(slotOne)Btn")
        self.slotTwo.image = UIImage(named: "\(slotTwo)Btn")
        pokemonTitle.text = pokemon.name.capitalized
        activityIndicator.startAnimating()
        presenter?.updateView(id: pokemon.id)
        
        pokemonHeight.text = pokemon.height + "m"
        pokemonWeight.text = pokemon.weight + "kg"
        prepareNewPokemonCell(pokemon.stats, slotColor: color)
        self.tableView.reloadData()
    }
    
    func showPokemonSpecie(_ pokemon: PokemonSpecieDto) {
        self.activityIndicator.stopAnimating()
        pokemonDescription.text = pokemon.text_entries
    }
    
    func error() {
        view.makeToast("Error en servicio", duration: 3.0, position: .bottom)
        self.activityIndicator.stopAnimating()
    }
    
    private func imageView(path: String?) {
        if let iconUrl = path, let url = Tools.getPosterImage(iconUrl) {
            self.pokemonImage.kf.setImage(with: url, options: [.backgroundDecode])
        }
    }
}

extension PokemonDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCell(at indexPath: IndexPath) -> PokemonDetailViewCell {
        return cellViewModels[indexPath.row]
    }
    
    func prepareNewPokemonCell(_ pokemons: [PokemonStatsDto], slotColor: slotColor?) {
        var pokemonCell = [PokemonDetailViewCell]()
        if !pokemons.isEmpty {
            pokemons.forEach { (pokemon) in
                pokemonCell.append(self.createCellViewModel(pokemon: pokemon, slotColor: slotColor))
            }
            self.cellViewModels = pokemonCell
        }
    }
    
    func createCellViewModel(pokemon: PokemonStatsDto, slotColor: slotColor?) -> PokemonDetailViewCell {
        
        return PokemonDetailViewCell(statName: pokemon.name, baseStat: pokemon.base_stat, color: slotColor)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = Bundle.main.loadNibNamed("PokemonDetailTableViewCell", owner: self, options: nil)?.first as? PokemonDetailTableViewCell else { fatalError("Cell not exists")}
        let cellPresenter = getCell(at: indexPath)
        cell.pokemonDetailView = cellPresenter
        
        return cell
    }
    
}
