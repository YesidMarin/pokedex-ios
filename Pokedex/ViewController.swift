//
//  ViewController.swift
//  Pokedex
//
//  Created by Yesid Marin on 16/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .black
        tabBar.backgroundColor = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.viewControllers = [ PokemonTabBar,MovesTabBar,ItemsTabBar]
    }

    lazy public var PokemonTabBar = setTabBarController(viewController: PokemonRouter.createModule(), title: "Pokemon", image: "InactiveIconOne", selectedImage: "ActiveIconOne")
    
    lazy public var MovesTabBar = setTabBarController(viewController: MovesRouter.createModule(), title: "Moves", image: "InactiveIconTwo", selectedImage: "ActiveIconTwo")
    
    lazy public var ItemsTabBar = setTabBarController(viewController: ItemsRouter.createModule(), title: "Items", image: "InactiveIconThree", selectedImage: "ActiveIconThree")
    
}

extension UITabBarController {
    func setTabBarController(viewController: UIViewController, title: String, image: String, selectedImage: String) -> UINavigationController {
        
        let image = UIImage(named: image)
        let selectedImage = UIImage(named: selectedImage)
   
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        viewController.tabBarItem = tabBarItem
        
        return UINavigationController(rootViewController: viewController)
    }
}

