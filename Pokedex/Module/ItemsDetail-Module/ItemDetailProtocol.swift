//
//  ItemDetailProtocol.swift
//  Pokedex
//
//  Created by Yesid Marin on 17/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation

import UIKit

protocol ItemDetailViewProtocol {
    
    var presenter: ItemDetailPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showItem(_ item: ItemBodyDto)
}

protocol ItemDetailPresenterProtocol: class {
    
    var view: ItemDetailViewProtocol? { get set }
    var interactor: ItemDetailInteractorInputProtocol? { get set }
    var router: ItemDetailRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
}

protocol ItemDetailInteractorInputProtocol: class {
    
    var presenter: ItemDetailInteractorOutputProtocol? { get set }
    var item: ItemBodyDto? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol ItemDetailInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
}

protocol ItemDetailRouterProtocol: class {
    
    static func createDetailRouterModule(with item: ItemBodyDto) -> UIViewController
    
    // PRESENTER -> ROUTER
    func navigateBackToListViewController(from view: ItemDetailViewProtocol)
    
}
