//
//  ItemsPresenter.swift
//  Pokedex
//
//  Created by Yesid Marin on 16/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation

class ItemsPresenter: ItemsPresenterProtocol {
    
    weak var view: ItemsViewProtocol?
    var interator: ItemsInteractorInputProtocol?
    var router: ItemsRouterProtocol?
    
    func updateView() {
        interator?.fetchItems()
    }
    
    func updateNextRecordView(url: String) {
        interator?.fetchItems(url: url)
    }
}

extension ItemsPresenter: ItemsInteractorOutputProtocol {
    func getItems(items: ItemsDto) {
        view?.showItems(listItems: items)
        view?.createCell()
    }
    
    func getItemsFailed() {
        view?.error()
    }
}
