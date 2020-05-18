//
//  PokemonDetailRouter.swift
//  Pokedex
//
//  Created by Yesid Marin on 17/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import UIKit

class PokemonDetailRouter: PokemonDetailRouterProtocol {

    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static func createDetailRouterModule(with pokemon: PokemonBodyDto) -> UIViewController {
        guard let view = storyboard.instantiateViewController(withIdentifier: "PokemonDetailViewController") as? PokemonDetailViewController else { fatalError("Invalid view controller type")}
        
        let presenter: PokemonDetailPresenter & PokemonDetailInteractorOutputProtocol = PokemonDetailPresenter()
        view.presenter = presenter
        presenter.view = view
        let interactor: PokemonDetailInteractorInputProtocol = PokemonDetailInteractor()
        interactor.pokemon = pokemon
        interactor.presenter = presenter
        presenter.interactor = interactor
        let router: PokemonDetailRouterProtocol = PokemonDetailRouter()
        presenter.router = router
        
        return view
    }
    
    func navigateBackToListViewController(from view: PokemonDetailViewProtocol) {
        guard let viewVC = view as? UIViewController else {
                   fatalError("Invalid view protocol type")
               }
        viewVC.navigationController?.popViewController(animated: true)
    }
}
