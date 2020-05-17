//
//  MovesDto.swift
//  Pokedex
//
//  Created by Yesid Marin on 17/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation

struct MovesDto {
    var next: String
    var moves: [MoveBodyDto]
}

struct MoveBodyDto {
    var moveTitle: String
    var moveTypeSlot: String
    var moveUrl: String
}
