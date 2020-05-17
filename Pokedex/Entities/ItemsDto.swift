//
//  ItemsDto.swift
//  Pokedex
//
//  Created by Yesid Marin on 17/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation

struct ItemsDto {
    var next: String
    var items: [ItemsBodyDto]
}

struct ItemsBodyDto {
    var itemTitle: String
    var cost: Int
    var sprit: String
}

