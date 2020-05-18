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
        
        var pokemonDescription: [PokemonDescriptionDto] = [PokemonDescriptionDto]()
        
        let url = URLService.buildURLPokemonsDescription(id: query)
        AF.request(url).responseDecodable { (dataResponse: AFDataResponse<DetailPokemon>) in
            switch dataResponse.result {
            case .failure(_):
                self.presenter?.getPokemonSearchFailed()
            case .success(let value):
                let types = value.types.map({PokemonDescriptionDto(slot: $0.slot, nameSlot: $0.type.name)})
                pokemonDescription.append(contentsOf: types)
                let stats = value.stats.map({PokemonStatsDto(name: $0.stat.name, base_stat: "\($0.base_stat)")})
                let body = PokemonBodyDto(id: "\(value.id)",name: query, url: "", description: pokemonDescription, height: "\(value.height)", weight: "\(value.weight)", stats: stats)
                self.presenter?.getPokemon(pokemon: body)
            }
        }
    }
        
    private func loopDetailPokemons(response: PokemonResponse) {
        
        var pokemonBody: [PokemonBodyDto] = [PokemonBodyDto]()
        
        var name = ""
        let dispatchQueue = DispatchQueue(label: "dispatchQueue", qos: .background)
        let semaphore = DispatchSemaphore(value: 0)
        
        dispatchQueue.async {
            for data in response.results {
                name = data.name
                var pokemonDescription: [PokemonDescriptionDto] = [PokemonDescriptionDto]()
                
                let url = URLService.buildURLPokemonsDescription(id: data.name)
                AF.request(url).responseDecodable { (dataResponse: AFDataResponse<DetailPokemon>) in
                    switch dataResponse.result {
                    case .failure(_):
                        self.presenter?.getPokemonsFailed()
                    case .success(let value):
                        let types = value.types.map({PokemonDescriptionDto(slot: $0.slot, nameSlot: $0.type.name)})
                        pokemonDescription.append(contentsOf: types)
                        let stats = value.stats.map({PokemonStatsDto(name: $0.stat.name, base_stat: "\($0.base_stat)")})
                        let body = PokemonBodyDto(id: "\(value.id)",name: name, url: data.url, description: pokemonDescription, height: "\(value.height)", weight: "\(value.weight)", stats: stats)
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
