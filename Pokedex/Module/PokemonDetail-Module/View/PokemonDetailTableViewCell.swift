//
//  PokemonDetailTableViewCell.swift
//  Pokedex
//
//  Created by Yesid Marin on 18/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import UIKit

class PokemonDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detail: UILabel!
    
    var pokemonDetailView: PokemonDetailViewCell? {
        didSet {
            detailTitle.changeTextColor((self.pokemonDetailView?.color)!)
            detailTitle.text = self.pokemonDetailView?.statName
            detail.text = self.pokemonDetailView?.baseStat
        }
    }
}
