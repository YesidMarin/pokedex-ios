//
//  PokemonDetailProtocol.swift
//  Pokedex
//
//  Created by Yesid Marin on 17/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import UIKit

protocol PokemonDetailViewProtocol {
    
    var presenter: PokemonDetailPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showPokemon(_ pokemon: PokemonBodyDto)
    func showPokemonSpecie(_ pokemon: PokemonSpecieDto)
    func error()
}

protocol PokemonDetailPresenterProtocol: class {
    
    var view: PokemonDetailViewProtocol? { get set }
    var interactor: PokemonDetailInteractorInputProtocol? { get set }
    var router: PokemonDetailRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func updateView(id: String)
}

protocol PokemonDetailInteractorInputProtocol: class {
    
    var presenter: PokemonDetailInteractorOutputProtocol? { get set }
    var pokemon: PokemonBodyDto? { get set }
    
    // PRESENTER -> INTERACTOR
    func fetchPokemonSpecie(id: String)
}

protocol PokemonDetailInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func getPokemonFailed()
    func getPokemonSpecie(pokemon: PokemonSpecieDto)
}

protocol PokemonDetailRouterProtocol: class {
    
    static func createDetailRouterModule(with pokemon: PokemonBodyDto) -> UIViewController
    
    // PRESENTER -> ROUTER
    func navigateBackToListViewController(from view: PokemonDetailViewProtocol)
    
}
