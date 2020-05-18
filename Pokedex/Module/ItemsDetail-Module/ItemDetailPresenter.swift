//
//  ItemDetailPresenter.swift
//  Pokedex
//
//  Created by Yesid Marin on 17/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation

class ItemDetailPresenter: ItemDetailPresenterProtocol {
    
    var view: ItemDetailViewProtocol?
    var interactor: ItemDetailInteractorInputProtocol?
    var router: ItemDetailRouterProtocol?
    
    func viewDidLoad() {
        if let item = interactor?.item {
            view?.showItem(item)
        }
    }
}

extension ItemDetailPresenter : ItemDetailInteractorOutputProtocol {
 
}
