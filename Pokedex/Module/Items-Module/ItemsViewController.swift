//
//  ItemsViewController.swift
//  Pokedex
//
//  Created by Yesid Marin on 16/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController {
    
    // Table propierties
    var reloadTableViewModel: (() -> ()) = {}
    private var cellViewModels: [ItemsViewCell] = [ItemsViewCell](){
        didSet {
            self.reloadTableViewModel()
        }
    }
    
    var fetchingMore = false
    var items: [ItemBodyDto] = [ItemBodyDto]()
    var nextRecords = ""
    
    @IBOutlet weak var viewOpacity: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    var presenter: ItemsPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        
        self.navigationItem.title = "Items"
        presenter?.updateView()
        tableView.register(UINib(nibName: "ItemsTableViewCell", bundle: nil), forCellReuseIdentifier: "itemsViewCell")
        
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
        
        reloadTableViewModel = {() in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                self.view.isUserInteractionEnabled = true
            }
        }
    }
    
    func initView(){
       viewOpacity.changeBackgroundColor(backgroundColorScreens.inital)
    }
}

extension ItemsViewController: ItemsViewProtocol {
    func showItems(listItems: ItemsDto) {
        items.append(contentsOf: listItems.items)
        nextRecords = listItems.next
    }
    
    func createCell() {
        prepareNewItemCell(items)
    }
    
    func error(error: String?) {
        if let error = error {
            view.makeToast(error, duration: 3.0, position: .bottom)
        } else {
            view.makeToast("Error en servicio", duration: 3.0, position: .bottom)
        }
        activityIndicator.stopAnimating()
    }
}

struct ItemsViewCell {
    let icon: String
    let itemTitle: String
    let itemCost: Int
}

extension ItemsViewController: UITableViewDelegate, UITableViewDataSource {
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCell(at indexPath: IndexPath) -> ItemsViewCell {
        return cellViewModels[indexPath.row]
    }
    
    func prepareNewItemCell(_ moves: [ItemBodyDto]) {
        var moveCell = [ItemsViewCell]()
        if !moves.isEmpty {
            moveCell = moves.map({self.createCellViewModel(move: $0)})
            self.cellViewModels = moveCell
        }
    }
    
    func createCellViewModel(move: ItemBodyDto) -> ItemsViewCell {
        return ItemsViewCell(icon: move.sprit, itemTitle: move.itemTitle, itemCost: move.cost)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = Bundle.main.loadNibNamed("ItemsTableViewCell", owner: self, options: nil)?.first as? ItemsTableViewCell else { fatalError("Cell not exists")}
        let cellPresenter = getCell(at: indexPath)
        cell.itemView = cellPresenter
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showItemDetail(items[indexPath.row])
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
            view.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.presenter?.updateNextRecordView(url: self.nextRecords)
                self.fetchingMore = false
            }
        }
    }
}

extension ItemsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        
        let query = searchBar.text!.replacingOccurrences(of: " ", with: "-").lowercased()
        presenter?.searchItem(search: query)
    }
}
