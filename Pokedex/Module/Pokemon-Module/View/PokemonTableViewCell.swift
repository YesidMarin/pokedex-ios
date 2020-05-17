//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Yesid Marin on 16/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import UIKit
import Kingfisher

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var pokemonTitle: UILabel!
    @IBOutlet weak var pokemonNumber: UILabel!
    
    @IBOutlet weak var firstSlot: UIImageView!
    @IBOutlet weak var secondSlot: UIImageView!
    @IBOutlet weak var threeSlot: UIImageView!
    @IBOutlet weak var fourSlot: UIImageView!
    
    
    var pokemonView: PokemonViewCell? {
        didSet {
            iconView(path: self.pokemonView?.pokemonTitle)
            pokemonTitle.text = self.pokemonView?.pokemonTitle.capitalized
            pokemonNumber.text = self.pokemonView?.pokemonNumber
            firstSlot.image = UIImage(named: self.pokemonView?.pokemonFirstSlot.capitalized ?? "")
            secondSlot.image = UIImage(named: self.pokemonView?.pokemonSecondSlot.capitalized ?? "")
            threeSlot.image = UIImage(named: self.pokemonView?.pokemonThreeSlot.capitalized ?? "")
            fourSlot.image = UIImage(named: self.pokemonView?.pokemonFourSlot.capitalized ?? "")

        }
    }
    
    private func iconView(path: String?) {
        if let iconUrl = path, let url = Tools.getPosterImage(iconUrl) {
            self.icon.kf.setImage(with: url, options: [.backgroundDecode])
        }
    }
}
