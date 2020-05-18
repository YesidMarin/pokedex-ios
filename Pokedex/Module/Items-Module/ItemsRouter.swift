//
//  ItemsRouter.swift
//  Pokedex
//
//  Created by Yesid Marin on 16/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import UIKit

class ItemsRouter: ItemsRouterProtocol {
    
    static var mainStoryBoard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static func createModule() -> UIViewController {
        
        guard let view = mainStoryBoard.instantiateViewController(withIdentifier: "ItemsViewController") as? ItemsViewController else { fatalError("Invalid view controller type")}
        
        let presenter: ItemsPresenterProtocol & ItemsInteractorOutputProtocol = ItemsPresenter()
        let interactor: ItemsInteractorInputProtocol = ItemsInteractor()
        let router: ItemsRouterProtocol = ItemsRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interator = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func presentItemDetailScreen(from view: ItemsViewProtocol, for item: ItemBodyDto) {
        let moveDetailVC = ItemDetailRouter.createDetailRouterModule(with: item)
        
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid View Protocol type")
        }
        
        viewVC.navigationController?.pushViewController(moveDetailVC, animated: true)
    }
    
}
