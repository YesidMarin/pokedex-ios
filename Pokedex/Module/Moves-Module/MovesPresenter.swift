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
    
    func showMoveDetail(_ move: MoveBodyDto) {
        guard let view = view else { return }
        router?.presentMoveDetailScreen(from: view, for: move)
    }
    
    func searchMove(search: String) {
        interator?.fetchMove(search: search)
    }
}

extension MovesPresenter: MovesInteractorOutputProtocol {
    
    func getMoves(moves: MovesDto) {
        view?.showMoves(listMoves: moves)
        view?.createCell()
    }
    
    func getMove(move: MoveBodyDto) {
        guard let view = view else { return }
        router?.presentMoveDetailScreen(from: view, for: move)
    }
    
    func getMovesFailed() {
        view?.error(error: nil)
    }
    
    func getMoveSearchFailed() {
        view?.error(error: "No hay coincidencias")
    }
}
