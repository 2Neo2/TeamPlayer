//
//  PlaylistConfigurator.swift
//  TeamPlayer
//
//  Created by Иван Доронин on 08.05.2024.
//

import UIKit

protocol PlaylistConfiguratorProtocol {
    static func configure(with model: PlaylistViewModel) -> UIViewController
}

final class PlaylistConfigurator: PlaylistConfiguratorProtocol {
    static func configure(with model: PlaylistViewModel) -> UIViewController {
        let view = PlaylistViewController()
        view.currentModel = model
        let router = PlaylistRouter()
        let presenter = PlaylistPresenter()
        
        router.view = view
        presenter.router = router
        view.presenter = presenter
        presenter.view = view
        return view
    }
}

