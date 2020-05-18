//
//  URLService.swift
//  Pokedex
//
//  Created by Yesid Marin on 16/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation

class URLService {
    
    private static let url_service = "https://pokeapi.co/api/v2/"
    private static let url_images = "https://pokeres.bastionbot.org/images/pokemon/"
    private static let url_items_images = "https://img.pokemondb.net/sprites/items/"
    
    // MARK: Pokemons
    static func buildURLPokemons() -> String {
        return url_service + "pokemon"
    }
    
    static func buildURLPokemonsDescription(id: String) -> String {
        return "\(buildURLPokemons())/\(id)"
    }
    
    static func buildURLPokemonSpecies(id: String) -> String {
        return url_service + "pokemon-species/\(id)"
    }
    
    // MARK: Moves
    
    static func buildURLMoves() -> String {
        return url_service + "move"
    }
    
    static func buildURLMovesDescription(id: String) -> String {
        return "\(buildURLMoves())/\(id)"
    }
    
    // MARK: Items
    
    static func buildURLItems() -> String {
        return url_service + "item"
    }
    
    static func buildURLItemsDescription(id: String) -> String {
        return "\(buildURLItems())/\(id)"
    }
    
    // MARK: Image
    
    static func buildURLImages() -> String {
        return url_images
    }
    
    static func buildURLItemsImages() -> String {
        return url_items_images
    }
}
