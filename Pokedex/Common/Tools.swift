//
//  Tools.swift
//  Pokedex
//
//  Created by Yesid Marin on 16/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation
import UIKit

class Tools {
    
    static func globalNavegationBarInit(){
        let navigationAppearance = UINavigationBar.appearance()
        navigationAppearance.barStyle = .default
        navigationAppearance.setBackgroundImage(UIImage(), for: .default)
        navigationAppearance.shadowImage = UIImage()
        navigationAppearance.isTranslucent = true
        navigationAppearance.backgroundColor = .clear
        navigationAppearance.barTintColor = .white
        navigationAppearance.tintColor = .white
    }
    
    static func getPosterImage(_ path: String) -> URL?{
        let urlPath = URLService.buildURLImages() + path + ".jpg"
        return URL(string: urlPath)
    }
    
    static func getItemImage(_ path: String) -> URL?{
        let urlPath = URLService.buildURLItemsImages() + path + ".png"
        return URL(string: urlPath)
    }
}
