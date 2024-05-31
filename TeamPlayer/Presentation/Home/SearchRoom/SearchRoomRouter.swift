//
//  SearchRoomRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 26.05.2024.
//

import UIKit

protocol SearchRoomRouterProtocol {
    func openSingleFlow(with model: CreateRoomModel)
}

final class SearchRoomRouter: SearchRoomRouterProtocol {
    weak var view: SearchRoomViewController?
    
    func openSingleFlow(with model: CreateRoomModel) {
        guard let view else {return}
        
        let roomModel = RoomViewModel(id: model.id, name: model.name, creatorID: model.creator.id, isPrivate: model.isPrivate, desctiption: model.description)
        
        let presentVC = SelectedRoomConfigurator.configure(with: roomModel)
        
        view.navigationController?.pushViewController(presentVC, animated: true)
    }
}
