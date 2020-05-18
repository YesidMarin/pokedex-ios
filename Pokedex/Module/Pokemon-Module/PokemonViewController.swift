//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Yesid Marin on 16/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import UIKit
import Toast

class PokemonViewController: UIViewController {
    
    // Table propierties
    var reloadTableViewModel: (() -> ()) = {}
    private var cellViewModels: [PokemonViewCell] = [PokemonViewCell](){
        didSet {
            self.reloadTableViewModel()
        }
    }
    
    var pokemons: [PokemonBodyDto] = [PokemonBodyDto]()
    var nextRecords = ""
    var fetchingMore = false
    
    @IBOutlet weak var viewOpacity: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    var presenter: PokemonPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
        self.navigationItem.title = "Pokemon"
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        
        presenter?.updateView()
        tableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "pokemonViewCell")
        
   
        
        activityIndicator.startAnimating()
        
        reloadTableViewModel = {() in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func initView(){
        viewOpacity.changeBackgroundColor(backgroundColorScreens.inital)
    }
}

extension PokemonViewController: PokemonViewProtocol {
    
    func showPokemons(listPokemons: PokemonDto) {
        pokemons.append(contentsOf: listPokemons.pokemon)
        nextRecords = listPokemons.next
    }
    
    func createCell() {
        prepareNewPokemonCell(pokemons)
    }
    
    func error(error: String?) {
        if let error = error {
            view.makeToast(error, duration: 3.0, position: .bottom)
        } else {
            view.makeToast("Error en servicio", duration: 3.0, position: .bottom)
        }
        activityIndicator.stopAnimating()
    }
}

struct PokemonViewCell {
    let pokemonId: String
    let pokemonTitle: String
    let pokemonNumber: String
    let pokemonUrl: String
    let pokemonFirstSlot: String
    let pokemonSecondSlot: String
}

extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCell(at indexPath: IndexPath) -> PokemonViewCell {
        return cellViewModels[indexPath.row]
    }
    
    func prepareNewPokemonCell(_ pokemons: [PokemonBodyDto]) {
        var pokemonCell = [PokemonViewCell]()
        if !pokemons.isEmpty {
            for (var i,pokemon) in pokemons.enumerated() {
                i += 1
                pokemonCell.append(self.createCellViewModel(pokemon: pokemon, number: i))
            }
            self.cellViewModels = pokemonCell
        }
    }
    
    func createCellViewModel(pokemon: PokemonBodyDto, number: Int) -> PokemonViewCell {
        let currentNumber = "#\(String(format: "%03d", number))"
        var slotOne = ""
        var slotTwo = ""
        
        let filterSlotOne = pokemon.description.filter({$0.slot == 1}).first
        let filterSlotTwo = pokemon.description.filter({$0.slot == 2}).first
        slotOne = filterSlotOne?.nameSlot ?? "None"
        slotTwo = filterSlotTwo?.nameSlot ?? "None"
       
        
        return PokemonViewCell(pokemonId: pokemon.id, pokemonTitle: pokemon.name, pokemonNumber: currentNumber, pokemonUrl: pokemon.url,pokemonFirstSlot: slotOne, pokemonSecondSlot: slotTwo)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = Bundle.main.loadNibNamed("PokemonTableViewCell", owner: self, options: nil)?.first as? PokemonTableViewCell else { fatalError("Cell not exists")}
        let cellPresenter = getCell(at: indexPath)
        cell.pokemonView = cellPresenter
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showPokemonDetail(pokemons[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                beginBatchFetch()
            }
        }
    }
    
    func beginBatchFetch() {
        if !nextRecords.isEmpty {
            fetchingMore = true
            activityIndicator.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.presenter?.updateNextRecordView(url: self.nextRecords)
                self.fetchingMore = false
            }
        }
    }
}

extension PokemonViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        let query = searchBar.text!.replacingOccurrences(of: " ", with: "-").lowercased()
        presenter?.searchPokemon(search: query)
    }
}
