//
//  MovesTableViewCell.swift
//  Pokedex
//
//  Created by Yesid Marin on 17/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import UIKit

class MovesTableViewCell: UITableViewCell {

    @IBOutlet weak var moveTitle: UILabel!
    @IBOutlet weak var moveSlot: UIImageView!
    
    var moveView: MovesViewCell? {
        didSet {
            moveTitle.text = self.moveView?.moveTitle.capitalized
            moveSlot.image = UIImage(named: self.moveView?.moveSlot.capitalized ?? "")
        }
    }
    
}
