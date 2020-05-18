//
//  ItemDetailInterceptor.swift
//  Pokedex
//
//  Created by Yesid Marin on 17/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation

class ItemDetailInterceptor: ItemDetailInteractorInputProtocol {
    
    var presenter: ItemDetailInteractorOutputProtocol?
    var item: ItemBodyDto?
}
