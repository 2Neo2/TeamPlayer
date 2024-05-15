//
//  CreateRoomConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 09.04.2024.
//

import UIKit

protocol CreateRoomConfiguratorProtocol {
    static func configure(with delegate: CreateRoomVCProtocol) -> UIViewController
}

final class CreateRoomConfigurator: CreateRoomConfiguratorProtocol {
    static func configure(with delegate: CreateRoomVCProtocol) -> UIViewController {
        let view = CreateRoomViewController()
        view.delegate = delegate
        let router = CreateRoomRouter()
        let presenter = CreateRoomPresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
