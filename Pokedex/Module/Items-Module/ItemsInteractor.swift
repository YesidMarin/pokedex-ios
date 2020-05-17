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
    
    private func loopDetailItems(response: ItemsResponse) {
        
        var itemsBody: [ItemsBodyDto] = [ItemsBodyDto]()
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
                            itemsBody.append(ItemsBodyDto(itemTitle: name, cost: data.cost, sprit: data.sprites.default))
                            semaphore.signal()
                    }
                }
                semaphore.wait()
            }
            self.presenter?.getItems(items: ItemsDto(next: response.next ?? "", items: itemsBody))
        }
    }
}
