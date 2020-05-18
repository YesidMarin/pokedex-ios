//
//  MoveDetailPresenter.swift
//  Pokedex
//
//  Created by Yesid Marin on 17/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation

class MoveDetailPresenter: MoveDetailPresenterProtocol {
    
    var view: MoveDetailViewProtocol?
    var interactor: MoveDetailInteractorInputProtocol?
    var router: MoveDetailRouterProtocol?
    
    func viewDidLoad() {
        if let move = interactor?.move {
            view?.showMove(move)
        }
    }
}

extension MoveDetailPresenter : MoveDetailInteractorOutputProtocol {
 
}
