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
    
    func showItemDetail(_ item: ItemBodyDto) {
        guard let view = view else { return }
        router?.presentItemDetailScreen(from: view, for: item)
    }
    
    func searchItem(search: String) {
        interator?.fetchItem(search: search)
    }
}

extension ItemsPresenter: ItemsInteractorOutputProtocol {
    
    func getItems(items: ItemsDto) {
        view?.showItems(listItems: items)
        view?.createCell()
    }
    
    func getItemsFailed() {
        view?.error(error: nil)
    }
    
    func getItem(item: ItemBodyDto) {
        guard let view = view else { return }
        router?.presentItemDetailScreen(from: view, for: item)
    }
    
    func getItemSearchFailed() {
        view?.error(error: "No hay coincidencias")
    }
}
