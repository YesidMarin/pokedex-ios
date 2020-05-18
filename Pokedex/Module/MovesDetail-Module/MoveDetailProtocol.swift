//
//  MoveDetailProtocol.swift
//  Pokedex
//
//  Created by Yesid Marin on 17/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation
import UIKit

protocol MoveDetailViewProtocol {
    
    var presenter: MoveDetailPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showMove(_ move: MoveBodyDto)
}

protocol MoveDetailPresenterProtocol: class {
    
    var view: MoveDetailViewProtocol? { get set }
    var interactor: MoveDetailInteractorInputProtocol? { get set }
    var router: MoveDetailRouterProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
}

protocol MoveDetailInteractorInputProtocol: class {
    
    var presenter: MoveDetailInteractorOutputProtocol? { get set }
    var move: MoveBodyDto? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol MoveDetailInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
}

protocol MoveDetailRouterProtocol: class {
    
    static func createDetailRouterModule(with move: MoveBodyDto) -> UIViewController
    
    // PRESENTER -> ROUTER
    func navigateBackToListViewController(from view: MoveDetailViewProtocol)
    
}
