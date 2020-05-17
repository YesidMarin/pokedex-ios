//
//  MovesViewController.swift
//  Pokedex
//
//  Created by Yesid Marin on 16/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import UIKit

class MovesViewController: UIViewController {
    
    // Table propierties
    var reloadTableViewModel: (() -> ()) = {}
    private var cellViewModels: [MovesViewCell] = [MovesViewCell](){
        didSet {
            self.reloadTableViewModel()
        }
    }
    
    var fetchingMore = false
    var moves: [MoveBodyDto] = [MoveBodyDto]()
    var nextRecords = ""
    
    @IBOutlet weak var viewOpacity: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    var presenter: MovesPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        
        presenter?.updateView()
        tableView.register(UINib(nibName: "MovesTableViewCell", bundle: nil), forCellReuseIdentifier: "movesViewCell")
        
        activityIndicator.startAnimating()
        
        reloadTableViewModel = {() in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
     func initView(){
        
         let gradientLayer = CAGradientLayer()
         gradientLayer.colors = [ColorsUtil.blue.cgColor, ColorsUtil.aquaMarine.cgColor, ColorsUtil.greenLight.cgColor, ColorsUtil.green.cgColor]
         gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
         gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
         gradientLayer.frame = view.frame
         viewOpacity.layer.addSublayer(gradientLayer)
     }
    
}

extension MovesViewController: MovesViewProtocol {
    
    func showMoves(listMoves: MovesDto) {
        moves.append(contentsOf: listMoves.moves)
        nextRecords = listMoves.next
    }
    
    func createCell() {
        prepareNewMoveCell(moves)
    }
    
    func error() {
        view.makeToast("Error en servicio", duration: 3.0, position: .bottom)
        activityIndicator.stopAnimating()
    }
}

struct MovesViewCell {
    let moveTitle: String
    let moveSlot: String
    let moveUrl: String
}

extension MovesViewController: UITableViewDelegate, UITableViewDataSource {
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCell(at indexPath: IndexPath) -> MovesViewCell {
        return cellViewModels[indexPath.row]
    }
    
    func prepareNewMoveCell(_ moves: [MoveBodyDto]) {
        var moveCell = [MovesViewCell]()
        if !moves.isEmpty {
            moveCell = moves.map({self.createCellViewModel(move: $0)})
            self.cellViewModels = moveCell
        }
    }
    
    func createCellViewModel(move: MoveBodyDto) -> MovesViewCell {
        return MovesViewCell(moveTitle: move.moveTitle, moveSlot: move.moveTypeSlot, moveUrl: move.moveUrl)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = Bundle.main.loadNibNamed("MovesTableViewCell", owner: self, options: nil)?.first as? MovesTableViewCell else { fatalError("Cell not exists")}
        let cellPresenter = getCell(at: indexPath)
        cell.moveView = cellPresenter
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                beginBatchFetch()
            }
        }
    }
    
    func beginBatchFetch() {
        if !nextRecords.isEmpty {
            fetchingMore = true
            activityIndicator.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.presenter?.updateNextRecordView(url: self.nextRecords)
                self.fetchingMore = false
            }
        }
    }
    
}
