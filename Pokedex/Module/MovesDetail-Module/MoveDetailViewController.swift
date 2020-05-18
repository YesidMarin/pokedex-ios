//
//  MoveDetailViewController.swift
//  Pokedex
//
//  Created by Yesid Marin on 17/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import UIKit

class MoveDetailViewController: UIViewController {

    
    @IBOutlet weak var viewOpacity: UIView!
    @IBOutlet weak var iconDetail: UIImageView!
    @IBOutlet weak var slotImage: UIImageView!
    @IBOutlet weak var moveTitle: UILabel!
    @IBOutlet weak var moveDescription: UILabel!
    @IBOutlet weak var moveBasePowerTitle: UILabel!
    @IBOutlet weak var moveAccuracyTitle: UILabel!
    @IBOutlet weak var movePpTitle: UILabel!
    @IBOutlet weak var moveBasePower: UILabel!
    @IBOutlet weak var moveAccuracy: UILabel!
    @IBOutlet weak var movePp: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    var presenter: MoveDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        stackView.addBackground(color: ColorsUtil.grayLight)
    }
}

extension MoveDetailViewController: MoveDetailViewProtocol {
    func showMove(_ move: MoveBodyDto) {
        
        let slot = slotColor(rawValue: move.moveTypeSlot)!
        viewOpacity.changeBackgroundColor(slot)
        moveBasePowerTitle.changeTextColor(slot)
        moveAccuracyTitle.changeTextColor(slot)
        movePpTitle.changeTextColor(slot)
        
        iconDetail.image = UIImage(named: move.moveTypeSlot.capitalized)
        slotImage.image = UIImage(named: "\(move.moveTypeSlot.capitalized)Btn")
        moveTitle.text = move.moveTitle.replacingOccurrences(of: "-", with: " ").capitalized
        moveDescription.text = move.effect.replacingOccurrences(of: "$effect_chance%", with: "\(move.effect_chance)%")
        moveBasePower.text = "\(move.power)"
        moveAccuracy.text = "\(move.accuracy)%"
        movePp.text = "\(move.pp)"
    }
}
