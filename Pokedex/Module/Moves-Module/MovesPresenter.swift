//
//  MovesPresenter.swift
//  Pokedex
//
//  Created by Yesid Marin on 16/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation

class MovesPresenter: MovesPresenterProtocol {
    
    weak var view: MovesViewProtocol?
    var interator: MovesInteractorInputProtocol?
    var router: MovesRouterProtocol?
    
    func updateView() {
        interator?.fetchMoves()
    }
    
    func updateNextRecordView(url: String) {
        interator?.fetchMoves(url: url)
    }
}

extension MovesPresenter: MovesInteractorOutputProtocol {
    
    func getMoves(moves: MovesDto) {
        view?.showMoves(listMoves: moves)
        view?.createCell()
    }
    
    func getMovesFailed() {
        view?.error()
    }
}
