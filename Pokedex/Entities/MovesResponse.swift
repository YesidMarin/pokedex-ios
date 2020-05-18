//
//  MovesResponse.swift
//  Pokedex
//
//  Created by Yesid Marin on 17/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation

struct MovesResponse: Decodable {
    let next: String?
    let results: [MovesResult]
}

struct MovesResult: Decodable {
    let name: String
    let url: String
}

struct MoveDescription: Decodable {
    let accuracy: Int?
    let effect_chance: Int?
    let effect_entries: [MoveEffectEntries]
    let power: Int?
    let pp: Int?
    let type: MoveDescriptionType
}

struct MoveEffectEntries: Decodable {
    let effect: String
}

struct MoveDescriptionType: Decodable {
    let name: String
}
