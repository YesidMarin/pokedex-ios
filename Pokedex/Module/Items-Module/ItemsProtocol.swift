//
//  ItemsProtocol.swift
//  Pokedex
//
//  Created by Yesid Marin on 16/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import UIKit

protocol ItemsPresenterProtocol: class {
    
    var view: ItemsViewProtocol? {get set}
    var interator: ItemsInteractorInputProtocol? {get set}
    var router: ItemsRouterProtocol? {get set}
    
    // VIEW -> PRESENTER
    func updateView()
    func updateNextRecordView(url: String)
}

protocol ItemsViewProtocol: class {
    
    // PRESENTER -> VIEW
    func showItems(listItems: ItemsDto)
    func createCell()
    func error()
}

protocol ItemsInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func getItems(items: ItemsDto)
    func getItemsFailed()
}

protocol ItemsInteractorInputProtocol: class {
    
    var presenter: ItemsInteractorOutputProtocol? {get set}
    
    // PRESENTER -> INTERACTOR
    func fetchItems()
    func fetchItems(url: String)
}

protocol ItemsRouterProtocol: class {
    // PRESENTER -> ROUTER
    static func createModule() -> UIViewController
    
}

