//
//  PokemonRouter.swift
//  Pokedex
//
//  Created by Yesid Marin on 16/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation
import UIKit

class PokemonRouter: PokemonRouterProtocol {
    
    static var mainStoryBoard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static func createModule() -> UIViewController {
        
        guard let view = mainStoryBoard.instantiateViewController(withIdentifier: "PokemonViewController") as? PokemonViewController else { fatalError("Invalid view controller type")}
        
        let presenter: PokemonPresenterProtocol & PokemonInteractorOutputProtocol = PokemonPresenter()
        let interactor: PokemonInteractorInputProtocol = PokemonInteractor()
        let router: PokemonRouterProtocol = PokemonRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interator = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func presentDetailPokemonScreen(from view: PokemonViewProtocol, for pokemon: FirstStepResults) {
        
    }
}
