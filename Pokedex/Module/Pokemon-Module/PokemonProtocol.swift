//
//  PokemonProtocol.swift
//  Pokedex
//
//  Created by Yesid Marin on 16/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation
import UIKit

protocol PokemonPresenterProtocol: class {
    
    var view: PokemonViewProtocol? {get set}
    var interator: PokemonInteractorInputProtocol? {get set}
    var router: PokemonRouterProtocol? {get set}
    
    // VIEW -> PRESENTER
    func updateView()
    func updateNextRecordView(url: String)
    func searchPokemon(search: String)
    func showPokemonDetail(_ pokemon: PokemonBodyDto)
}

protocol PokemonViewProtocol: class {
    
    // PRESENTER -> VIEW
    func showPokemons(listPokemons: PokemonDto)
    func createCell()
    func error(error: String?)
}

protocol PokemonInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func getPokemons(pokemons: PokemonDto)
    func getPokemon(pokemon: PokemonBodyDto)
    func getPokemonsFailed()
    func getPokemonSearchFailed()
}

protocol PokemonInteractorInputProtocol: class {
    
    var presenter: PokemonInteractorOutputProtocol? {get set}
    
    // PRESENTER -> INTERACTOR
    func fetchPokemons()
    func fetchPokemons(url: String)
    func fetchPokemon(query: String)
}

protocol PokemonRouterProtocol: class {
    
    // PRESENTER -> ROUTER
    static func createModule() -> UIViewController
    func presentDetailPokemonScreen(from view: PokemonViewProtocol, for pokemon: PokemonBodyDto)
}
