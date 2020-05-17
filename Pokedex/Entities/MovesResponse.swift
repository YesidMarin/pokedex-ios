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
    let type: MoveDescriptionType
}

struct MoveDescriptionType: Decodable {
    let name: String
}
