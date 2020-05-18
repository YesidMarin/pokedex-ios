//
//  MovesRouter.swift
//  Pokedex
//
//  Created by Yesid Marin on 16/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import UIKit

class MovesRouter: MovesRouterProtocol{
    
    static var mainStoryBoard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static func createModule() -> UIViewController {
        
        guard let view = mainStoryBoard.instantiateViewController(withIdentifier: "MovesViewController") as? MovesViewController else { fatalError("Invalid view controller type")}
        
        let presenter: MovesPresenterProtocol & MovesInteractorOutputProtocol = MovesPresenter()
        let interactor: MovesInteractorInputProtocol = MovesInteractor()
        let router: MovesRouterProtocol = MovesRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interator = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func presentMoveDetailScreen(from view: MovesViewProtocol, for move: MoveBodyDto) {
        let moveDetailVC = MoveDetailRouter.createDetailRouterModule(with: move)
        
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid View Protocol type")
        }
        
        viewVC.navigationController?.pushViewController(moveDetailVC, animated: true)
    }
}
