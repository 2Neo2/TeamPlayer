//
//  PublicRoomsRouter.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 02.05.2024.
//

import UIKit

protocol PublicRoomsRouterProtocol {
    func openSelectedRoom(with model: RoomViewModel)
}

final class PublicRoomsRouter: PublicRoomsRouterProtocol {
    weak var view: PublicRoomsViewController?
    
    func openSelectedRoom(with model: RoomViewModel) {
        guard let view else {return}
        
        let presentVC = SelectedRoomConfigurator.configure(with: model)
        
        view.navigationController?.pushViewController(presentVC, animated: true)
    }
}
