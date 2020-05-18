//
//  ItemsResponse.swift
//  Pokedex
//
//  Created by Yesid Marin on 17/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation

struct ItemsResponse: Decodable {
    let next: String?
    let results: [ItemsResult]
}

struct ItemsResult: Decodable {
    let name: String
    let url: String
}

struct ItemsDescription: Decodable {
    let cost: Int
    let effect_entries: [ItemEffectEntries]
    let sprites: ItemSprite
}

struct ItemEffectEntries: Decodable {
    let effect: String
}

struct ItemSprite: Decodable {
    let `default`: String
}
