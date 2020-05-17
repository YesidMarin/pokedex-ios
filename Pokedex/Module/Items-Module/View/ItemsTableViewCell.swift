//
//  ItemsTableViewCell.swift
//  Pokedex
//
//  Created by Yesid Marin on 17/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import UIKit

class ItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemNumber: UILabel!
    
    var itemView: ItemsViewCell? {
        didSet {
            if let item = itemView {
                iconView(path: item.itemTitle)
                itemTitle.text = item.itemTitle
                itemNumber.text = String(describing: item.itemCost)
            }
        }
    }
    
    private func iconView(path: String?) {
        if let iconUrl = path, let url = Tools.getItemImage(iconUrl) {
            self.icon.kf.setImage(with: url, options: [.backgroundDecode])
        }
    }
    
}
