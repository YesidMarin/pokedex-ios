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
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ColorsUtil.blue.cgColor, ColorsUtil.aquaMarine.cgColor, ColorsUtil.greenLight.cgColor, ColorsUtil.green.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = view.frame
        viewOpacity.layer.addSublayer(gradientLayer)
        
        
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
    
    func error() {
        view.makeToast("Error en servicio", duration: 3.0, position: .bottom)
        activityIndicator.stopAnimating()
    }
}

struct PokemonViewCell {
    let pokemonTitle: String
    let pokemonNumber: String
    let pokemonUrl: String
    let pokemonFirstSlot: String
    let pokemonSecondSlot: String
    let pokemonThreeSlot: String
    let pokemonFourSlot: String
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
        var slotOne = "None"
        var slotTwo = "None"
        var slotThree = "None"
        var slotFour = "None"
        
        
        pokemon.description.forEach { description in
            if description.slot == 1 {
                slotOne = description.nameSlot
            } else if description.slot == 2 {
                slotTwo = description.nameSlot
            } else if description.slot == 3 {
                slotThree = description.nameSlot
            } else if description.slot == 4 {
                slotFour = description.nameSlot
            }
        }
        
        return PokemonViewCell(pokemonTitle: pokemon.name, pokemonNumber: currentNumber, pokemonUrl: pokemon.url,pokemonFirstSlot: slotOne, pokemonSecondSlot: slotTwo, pokemonThreeSlot: slotThree, pokemonFourSlot: slotFour)
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
        
        let query = searchBar.text!.lowercased()
        if query.isEmpty {
            if pokemons.count > 0 {
                prepareNewPokemonCell(pokemons)
            }
        } else {
            pokemons.removeAll()
            presenter?.searchPokemon(search: query)
        }
    }
}
