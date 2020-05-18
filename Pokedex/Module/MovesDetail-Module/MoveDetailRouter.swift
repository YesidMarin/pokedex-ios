//
//  MoveDetailRouter.swift
//  Pokedex
//
//  Created by Yesid Marin on 17/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation
import UIKit

class MoveDetailRouter: MoveDetailRouterProtocol {
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static func createDetailRouterModule(with move: MoveBodyDto) -> UIViewController {
        guard let view = storyboard.instantiateViewController(withIdentifier: "MoveDetailViewController") as? MoveDetailViewController else { fatalError("Invalid view controller type")}
        
        let presenter: MoveDetailPresenter & MoveDetailInteractorOutputProtocol = MoveDetailPresenter()
        view.presenter = presenter
        presenter.view = view
        let interactor: MoveDetailInteractorInputProtocol = MoveDetailInterceptor()
        interactor.move = move
        interactor.presenter = presenter
        presenter.interactor = interactor
        let router: MoveDetailRouterProtocol = MoveDetailRouter()
        presenter.router = router
        
        return view
    }
    
    func navigateBackToListViewController(from view: MoveDetailViewProtocol) {
        guard let viewVC = view as? UIViewController else {
                   fatalError("Invalid view protocol type")
               }
        viewVC.navigationController?.popViewController(animated: true)
    }
    
    
}
