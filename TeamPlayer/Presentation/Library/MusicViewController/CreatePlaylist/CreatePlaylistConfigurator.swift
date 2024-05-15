//
//  CreatePlaylistConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 09.04.2024.
//

import UIKit

protocol CreatePlaylistConfiguratorProtocol {
    static func configure(with delegate: CreatePlaylistVCProtocol) -> UIViewController
}

final class CreatePlaylistConfigurator: CreatePlaylistConfiguratorProtocol {
    static func configure(with delegate: CreatePlaylistVCProtocol) -> UIViewController {
        let view = CreatePlaylistViewController()
        let router = CreatePlaylistRouter()
        let presenter = CreatePlaylistPresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
