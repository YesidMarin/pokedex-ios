//
//  MovesInteractor.swift
//  Pokedex
//
//  Created by Yesid Marin on 16/05/20.
//  Copyright © 2020 YesidMarin. All rights reserved.
//

import Foundation
import Alamofire

class MovesInteractor: MovesInteractorInputProtocol{
    
    var presenter: MovesInteractorOutputProtocol?
    
    func fetchMoves() {
        let url = URLService.buildURLMoves()
        AF.request(url).responseDecodable { (dataResponse: AFDataResponse<MovesResponse>) in
            switch dataResponse.result {
                case .failure(_):
                    self.presenter?.getMovesFailed()
                case .success(let value):
                    self.loopDetailMoves(response: value)
            }
        }
    }
    
    func fetchMoves(url: String) {
        AF.request(url).responseDecodable { (dataResponse: AFDataResponse<MovesResponse>) in
            switch dataResponse.result {
                case .failure(_):
                    self.presenter?.getMovesFailed()
                case .success(let value):
                    self.loopDetailMoves(response: value)
            }
        }
    }
    
    private func loopDetailMoves(response: MovesResponse) {
        
        var moveBody: [MoveBodyDto] = [MoveBodyDto]()
        var name = ""
        let dispatchQueue = DispatchQueue(label: "dispatchQueue", qos: .background)
        let semaphore = DispatchSemaphore(value: 0)
        
        dispatchQueue.async {
            for data in response.results {
                name = data.name
                let url = URLService.buildURLMovesDescription(id: data.name)
                AF.request(url).responseDecodable { (dataResponse: AFDataResponse<MoveDescription>) in
                    switch dataResponse.result {
                    case .failure(_):
                        self.presenter?.getMovesFailed()
                    case .success(let value):
                        moveBody.append(MoveBodyDto(moveTitle: name, moveTypeSlot: value.type.name, moveUrl: data.url))
                        semaphore.signal()
                    }
                }
                semaphore.wait()
            }
            self.presenter?.getMoves(moves: MovesDto(next: response.next ?? "", moves: moveBody))
        }
    }
}
