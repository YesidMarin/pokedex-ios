//
//  PokemonResponse.swift
//  Pokedex
//
//  Created by Yesid Marin on 16/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation

struct PokemonResponse: Decodable {
    let next: String?
    let results: [FirstStepResults]
}

struct FirstStepResults: Decodable {
    let name: String
    let url: String
}

struct DetailPokemon: Decodable {
    let types: [TypesPokemon]
}

struct TypesPokemon: Decodable {
    let slot: Int
    let type: TypesSlotPokemon
}
struct TypesSlotPokemon: Decodable {
    let name: String
    let url: String
}

 

