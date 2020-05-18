//
//  MoveDetailInterceptor.swift
//  Pokedex
//
//  Created by Yesid Marin on 17/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation
import UIKit

class MoveDetailInterceptor: MoveDetailInteractorInputProtocol {
    
    var presenter: MoveDetailInteractorOutputProtocol?
    var move: MoveBodyDto?
}
