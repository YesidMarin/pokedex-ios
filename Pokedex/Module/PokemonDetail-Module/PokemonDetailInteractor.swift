//
//  PokemonDetailInteractor.swift
//  Pokedex
//
//  Created by Yesid Marin on 17/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Alamofire

class PokemonDetailInteractor: PokemonDetailInteractorInputProtocol {
    
    var presenter: PokemonDetailInteractorOutputProtocol?
    var pokemon: PokemonBodyDto?
    
    func fetchPokemonSpecie(id: String) {
        let url = URLService.buildURLPokemonSpecies(id: id)
        AF.request(url).responseDecodable { (dataResponse: AFDataResponse<PokemonSpecie>) in
            switch dataResponse.result {
                case .failure(_):
                    self.presenter?.getPokemonFailed()
                case .success(let value):
                    let filter = value.flavor_text_entries.filter({$0.language.name == "en"}).first
                    self.presenter?.getPokemonSpecie(pokemon: PokemonSpecieDto(text_entries: filter?.flavor_text.replacingOccurrences(of: "\n", with: "") ?? ""))
            }
        }
    }
}
