//
//  ItemDetailViewController.swift
//  Pokedex
//
//  Created by Yesid Marin on 17/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    @IBOutlet weak var viewOpacity: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var costTitle: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    
    var presenter: ItemDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        viewOpacity.changeBackgroundColor(backgroundColorScreens.item)
    }
}

extension ItemDetailViewController: ItemDetailViewProtocol {
    func showItem(_ item: ItemBodyDto) {
        
        backdropImageView(path: item.sprit)
        itemTitle.text = item.itemTitle.replacingOccurrences(of: "-", with: " ").capitalized
        costTitle.text = "\(item.cost)"
        itemDescription.text = item.effect
    }
    
    private func backdropImageView(path: String?){
        if let posterUrl = path, let url = Tools.getItemImageWithoutExtension(posterUrl){
            self.image.kf.setImage(with: url, options: [.backgroundDecode])
        }
    }
}
