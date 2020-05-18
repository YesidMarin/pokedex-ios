//
//  PokemonDto.swift
//  Pokedex
//
//  Created by Yesid Marin on 16/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation

struct PokemonDto {
    var next: String
    var pokemon: [PokemonBodyDto]
}

struct PokemonBodyDto {
    var id: String
    var name: String
    var url: String
    var description: [PokemonDescriptionDto]
    let height: String
    let weight: String
    let stats: [PokemonStatsDto]
}

struct PokemonDescriptionDto {
    var slot: Int
    var nameSlot: String
}

struct PokemonStatsDto {
    var name: String
    var base_stat: String
}

struct PokemonSpecieDto {
    var text_entries: String
}
