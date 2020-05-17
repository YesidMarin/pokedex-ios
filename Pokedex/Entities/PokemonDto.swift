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
    var name: String
    var url: String
    var description: [DescriptionPokemonDto]
}

struct DescriptionPokemonDto {
    var slot: Int
    var nameSlot: String
}
