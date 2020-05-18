//
//  Styles.swift
//  Pokedex
//
//  Created by Yesid Marin on 17/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation
import UIKit

enum slotColor: String {
    case bug = "bug"
    case dark = "dark"
    case dragon = "dragon"
    case electric = "electric"
    case fairy = "fairy"
    case fighting = "fighting"
    case fire = "fire"
    case flying = "flying"
    case ghost = "ghost"
    case grass = "grass"
    case ground = "ground"
    case ice = "ice"
    case normal = "normal"
    case poison = "poison"
    case psychic = "psychic"
    case rock = "rock"
    case steel = "steel"
    case water = "water"
    
    var backgoundColor: [CGColor] {
        switch self {
        case .bug: return [ColorsUtil.bugOne.cgColor, ColorsUtil.bugTwo.cgColor]
        case .dark: return [ColorsUtil.darkOne.cgColor, ColorsUtil.darkTwo.cgColor]
        case .dragon: return [ColorsUtil.dragonOne.cgColor, ColorsUtil.dragonTwo.cgColor]
        case .electric: return [ColorsUtil.electricOne.cgColor, ColorsUtil.electricTwo.cgColor]
        case .fairy: return [ColorsUtil.fairyOne.cgColor, ColorsUtil.fairyTwo.cgColor]
        case .fighting: return [ColorsUtil.fightingOne.cgColor, ColorsUtil.fightingTwo.cgColor]
        case .fire: return [ColorsUtil.fireOne.cgColor, ColorsUtil.fireTwo.cgColor]
        case .flying: return [ColorsUtil.flyingOne.cgColor, ColorsUtil.flyingTwo.cgColor]
        case .ghost: return [ColorsUtil.ghostOne.cgColor, ColorsUtil.ghostTwo.cgColor]
        case .grass: return [ColorsUtil.grassOne.cgColor, ColorsUtil.grassTwo.cgColor]
        case .ground: return [ColorsUtil.groundOne.cgColor, ColorsUtil.groundTwo.cgColor]
        case .ice: return [ColorsUtil.iceOne.cgColor, ColorsUtil.iceTwo.cgColor]
        case .normal: return [ColorsUtil.normalOne.cgColor, ColorsUtil.normalTwo.cgColor]
        case .poison: return [ColorsUtil.poisonOne.cgColor, ColorsUtil.poisonTwo.cgColor]
        case .psychic: return [ColorsUtil.psychicOne.cgColor, ColorsUtil.psychicTwo.cgColor]
        case .rock: return [ColorsUtil.rockOne.cgColor, ColorsUtil.rockTwo.cgColor]
        case .steel: return [ColorsUtil.steelOne.cgColor, ColorsUtil.steelTwo.cgColor]
        case .water: return [ColorsUtil.waterOne.cgColor, ColorsUtil.waterTwo.cgColor]
        }
    }
    
    var textColor: UIColor {
        switch self {
            case .bug: return ColorsUtil.bugTwo
            case .dark: return ColorsUtil.darkTwo
            case .dragon: return ColorsUtil.dragonTwo
            case .electric: return ColorsUtil.electricTwo
            case .fairy: return ColorsUtil.fairyTwo
            case .fighting: return ColorsUtil.fightingTwo
            case .fire: return ColorsUtil.fireTwo
            case .flying: return ColorsUtil.flyingTwo
            case .ghost: return ColorsUtil.ghostTwo
            case .grass: return ColorsUtil.grassTwo
            case .ground: return ColorsUtil.groundTwo
            case .ice: return ColorsUtil.iceTwo
            case .normal: return ColorsUtil.normalTwo
            case .poison: return ColorsUtil.poisonTwo
            case .psychic: return ColorsUtil.psychicTwo
            case .rock: return ColorsUtil.rockTwo
            case .steel: return ColorsUtil.steelTwo
            case .water: return ColorsUtil.waterTwo
        }
    }
    
}
