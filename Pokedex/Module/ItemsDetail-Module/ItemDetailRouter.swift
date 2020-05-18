//
//  ItemDetailRouter.swift
//  Pokedex
//
//  Created by Yesid Marin on 17/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import UIKit

class ItemDetailRouter: ItemDetailRouterProtocol {
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static func createDetailRouterModule(with item: ItemBodyDto) -> UIViewController {
        guard let view = storyboard.instantiateViewController(withIdentifier: "ItemDetailViewController") as? ItemDetailViewController else { fatalError("Invalid view controller type")}
        
        let presenter: ItemDetailPresenter & ItemDetailInteractorOutputProtocol = ItemDetailPresenter()
        view.presenter = presenter
        presenter.view = view
        let interactor: ItemDetailInteractorInputProtocol = ItemDetailInterceptor()
        interactor.item = item
        interactor.presenter = presenter
        presenter.interactor = interactor
        let router: ItemDetailRouterProtocol = ItemDetailRouter()
        presenter.router = router
        
        return view
    }
    
    func navigateBackToListViewController(from view: ItemDetailViewProtocol) {
        guard let viewVC = view as? UIViewController else {
                   fatalError("Invalid view protocol type")
               }
        viewVC.navigationController?.popViewController(animated: true)
    }
    
    
}
