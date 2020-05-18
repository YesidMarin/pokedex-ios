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
    let id: Int
    let types: [TypesPokemon]
    let height: Int
    let weight: Int
    let stats: [PokemonBaseStat]
}

struct TypesPokemon: Decodable {
    let slot: Int
    let type: TypesSlotPokemon
}
struct TypesSlotPokemon: Decodable {
    let name: String
    let url: String
}

struct PokemonBaseStat: Decodable {
    let base_stat: Int
    let stat: PokemonStat
}

struct PokemonStat: Decodable {
    let name: String
}

struct PokemonSpecie: Decodable {
    let flavor_text_entries: [PokemonSpecieDetail]
}
 
struct PokemonSpecieDetail: Decodable {
    let flavor_text: String
    let language: PokemonSpecieDetailLang
}

struct PokemonSpecieDetailLang: Decodable {
    let name: String
}
