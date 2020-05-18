//
//  PokemonDetailPresenter.swift
//  Pokedex
//
//  Created by Yesid Marin on 17/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation

class PokemonDetailPresenter: PokemonDetailPresenterProtocol {
    
    var view: PokemonDetailViewProtocol?
    
    var interactor: PokemonDetailInteractorInputProtocol?
    
    var router: PokemonDetailRouterProtocol?
    
    func viewDidLoad() {
        if let pokemon = interactor?.pokemon {
            view?.showPokemon(pokemon)
        }
    }
    
    func updateView(id: String) {
        interactor?.fetchPokemonSpecie(id: id)
    }
}

extension PokemonDetailPresenter: PokemonDetailInteractorOutputProtocol {
    
    func getPokemonFailed() {
        view?.error()
    }
    
    func getPokemonSpecie(pokemon: PokemonSpecieDto) {
        view?.showPokemonSpecie(pokemon)
    }
    
}
