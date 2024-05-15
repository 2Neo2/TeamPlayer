//
//  SelectedRoomConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 04.04.2024.
//

import UIKit

protocol SelectedRoomConfiguratorProtocol {
    static func configure(with room: RoomViewModel) -> UIViewController
}

final class SelectedRoomConfigurator: SelectedRoomConfiguratorProtocol {
    static func configure(with room: RoomViewModel) -> UIViewController {
        let view = SelectedRoomViewController()
        view.currentRoom = room
        let router = SelectedRoomRouter()
        let presenter = SelectedRoomPresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
