//
//  MovesProtocol.swift
//  Pokedex
//
//  Created by Yesid Marin on 16/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import UIKit

protocol MovesPresenterProtocol: class {
    
    var view: MovesViewProtocol? {get set}
    var interator: MovesInteractorInputProtocol? {get set}
    var router: MovesRouterProtocol? {get set}
    
    // VIEW -> PRESENTER
    func updateView()
    func updateNextRecordView(url: String)
    func searchMove(search: String)
    func showMoveDetail(_ move: MoveBodyDto)
}

protocol MovesViewProtocol: class {
    
    // PRESENTER -> VIEW
    func showMoves(listMoves: MovesDto)
    func createCell()
    func error(error: String?)
}

protocol MovesInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func getMoves(moves: MovesDto)
    func getMove(move: MoveBodyDto)
    func getMovesFailed()
    func getMoveSearchFailed()
    
}

protocol MovesInteractorInputProtocol: class {
    
    var presenter: MovesInteractorOutputProtocol? {get set}
    
    // PRESENTER -> INTERACTOR
    func fetchMoves()
    func fetchMoves(url: String)
    func fetchMove(search: String)
}

protocol MovesRouterProtocol: class {
    
    // PRESENTER -> ROUTER
    static func createModule() -> UIViewController
    func presentMoveDetailScreen(from view: MovesViewProtocol, for move: MoveBodyDto)
}
