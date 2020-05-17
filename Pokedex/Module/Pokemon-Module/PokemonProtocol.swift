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
}

protocol PokemonViewProtocol: class {
    
    // PRESENTER -> VIEW
    func showPokemons(listPokemons: PokemonDto)
    func createCell()
    func error()
}

protocol PokemonInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func getPokemons(pokemons: PokemonDto)
    func getPokemonsFailed()
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
    func presentDetailPokemonScreen(from view: PokemonViewProtocol, for pokemon: FirstStepResults)
}
