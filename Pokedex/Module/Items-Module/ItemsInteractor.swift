//
//  ItemsInteractor.swift
//  Pokedex
//
//  Created by Yesid Marin on 16/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation
import Alamofire

class ItemsInteractor: ItemsInteractorInputProtocol {
    
    var presenter: ItemsInteractorOutputProtocol?
    
    func fetchItems() {
        let url = URLService.buildURLItems()
        AF.request(url).responseDecodable { (dataResponse: AFDataResponse<ItemsResponse>) in
            switch dataResponse.result {
                case .failure(_):
                    self.presenter?.getItemsFailed()
                case .success(let value):
                    self.loopDetailItems(response: value)
            }
        }
    }
    
    func fetchItems(url: String) {
        AF.request(url).responseDecodable { (dataResponse: AFDataResponse<ItemsResponse>) in
            switch dataResponse.result {
                case .failure(_):
                    self.presenter?.getItemsFailed()
                case .success(let value):
                    self.loopDetailItems(response: value)
            }
        }
    }
    
    func fetchItem(search: String) {
        let url = URLService.buildURLItemsDescription(id: search)
        AF.request(url).responseDecodable { (dataResponse: AFDataResponse<ItemsDescription>) in
            switch dataResponse.result {
                case .failure(_):
                    self.presenter?.getItemSearchFailed()
                case .success(let data):
                    self.presenter?.getItem(item: ItemBodyDto(itemTitle: search, cost: data.cost, sprit: data.sprites.default, effect: data.effect_entries[0].effect))
            }
        }
    }
    
    private func loopDetailItems(response: ItemsResponse) {
        
        var itemsBody: [ItemBodyDto] = [ItemBodyDto]()
        var name = ""
        let dispatchQueue = DispatchQueue(label: "dispatchQueue", qos: .background)
        let semaphore = DispatchSemaphore(value: 0)
        
        dispatchQueue.async {
            for data in response.results {
                name = data.name
                let url = URLService.buildURLItemsDescription(id: data.name)
                AF.request(url).responseDecodable { (dataResponse: AFDataResponse<ItemsDescription>) in
                    switch dataResponse.result {
                        case .failure(_):
                            self.presenter?.getItemsFailed()
                        case .success(let data):
                            itemsBody.append(ItemBodyDto(itemTitle: name, cost: data.cost, sprit: data.sprites.default, effect: data.effect_entries[0].effect))
                            semaphore.signal()
                    }
                }
                semaphore.wait()
            }
            self.presenter?.getItems(items: ItemsDto(next: response.next ?? "", items: itemsBody))
        }
    }
}
