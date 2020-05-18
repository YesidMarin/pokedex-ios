//
//  PokemonPresenter.swift
//  Pokedex
//
//  Created by Yesid Marin on 16/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation

class PokemonPresenter: PokemonPresenterProtocol {
    
    weak var view: PokemonViewProtocol?
    var interator: PokemonInteractorInputProtocol?
    var router: PokemonRouterProtocol?
    
    func updateView() {
        interator?.fetchPokemons()
    }
    
    func updateNextRecordView(url: String) {
        interator?.fetchPokemons(url: url)
    }
    
    func searchPokemon(search: String) {
        interator?.fetchPokemon(query: search)
    }
    
    func showPokemonDetail(_ pokemon: PokemonBodyDto) {
        guard let view = view else { return }
        router?.presentDetailPokemonScreen(from: view, for: pokemon)
    }
    
}

extension PokemonPresenter: PokemonInteractorOutputProtocol {
    
    func getPokemons(pokemons: PokemonDto) {
        view?.showPokemons(listPokemons: pokemons)
        view?.createCell()
    }
    
    func getPokemonsFailed() {
        view?.error(error: nil)
    }
    
    func getPokemon(pokemon: PokemonBodyDto) {
        guard let view = view else { return }
        router?.presentDetailPokemonScreen(from: view, for: pokemon)
    }
    
    func getPokemonSearchFailed() {
        view?.error(error: "No hay coincidencias")
    }
    
}
