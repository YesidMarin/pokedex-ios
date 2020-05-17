//
//  PokemonInteractor.swift
//  Pokedex
//
//  Created by Yesid Marin on 16/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation
import Alamofire

class PokemonInteractor: PokemonInteractorInputProtocol {
    
    var presenter: PokemonInteractorOutputProtocol?
    
    func fetchPokemons() {
        
        let url = URLService.buildURLPokemons()
        AF.request(url).responseDecodable { (dataResponse: AFDataResponse<PokemonResponse>) in
            switch dataResponse.result {
                case .failure(_):
                    self.presenter?.getPokemonsFailed()
                case .success(let value):
                    self.loopDetailPokemons(response: value)
            }
        }
    }
    
    func fetchPokemons(url: String) {
        
        AF.request(url).responseDecodable { (dataResponse: AFDataResponse<PokemonResponse>) in
            switch dataResponse.result {
                case .failure(_):
                    self.presenter?.getPokemonsFailed()
                case .success(let value):
                    self.loopDetailPokemons(response: value)
            }
        }
    }
    
    func fetchPokemon(query: String) {
        
        let url = URLService.buildURLSearchPokemon(query: query)
        AF.request(url).responseDecodable { (dataResponse: AFDataResponse<DetailPokemon>) in
            switch dataResponse.result {
                case .failure(_):
                    self.presenter?.getPokemonsFailed()
                case .success(let value):
                    print(value)
            }
        }
    }
        
    private func loopDetailPokemons(response: PokemonResponse) {
        
        var pokemonBody: [PokemonBodyDto] = [PokemonBodyDto]()
        
        var name = ""
        var descriptionPokemon: [DescriptionPokemonDto] = [DescriptionPokemonDto]()
        let dispatchQueue = DispatchQueue(label: "dispatchQueue", qos: .background)
        let semaphore = DispatchSemaphore(value: 0)
        
        dispatchQueue.async {
            for data in response.results {
                name = data.name
                let url = URLService.buildURLPokemonsDescription(id: data.name)
                AF.request(url).responseDecodable { (dataResponse: AFDataResponse<DetailPokemon>) in
                    switch dataResponse.result {
                    case .failure(_):
                        self.presenter?.getPokemonsFailed()
                    case .success(let value):
                        let types = value.types.map({DescriptionPokemonDto(slot: $0.slot, nameSlot: $0.type.name)})
                        descriptionPokemon.append(contentsOf: types)
                        
                        let body = PokemonBodyDto(name: name, url: data.url, description: descriptionPokemon)
                        pokemonBody.append(body)
                        semaphore.signal()
                    }
                   
                }
                
                semaphore.wait()
                
            }
            self.presenter?.getPokemons(pokemons: PokemonDto(next: response.next ?? "", pokemon: pokemonBody))
        }
    }
}
